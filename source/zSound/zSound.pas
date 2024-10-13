{ ****************************************************************************** }
{ * sound engine                                                               * }
{ * written by QQ 600585@qq.com                                                * }
{ * https://zpascal.net                                                        * }
{ * https://github.com/PassByYou888/zAI                                        * }
{ * https://github.com/PassByYou888/ZServer4D                                  * }
{ * https://github.com/PassByYou888/PascalString                               * }
{ * https://github.com/PassByYou888/zRasterization                             * }
{ * https://github.com/PassByYou888/CoreCipher                                 * }
{ * https://github.com/PassByYou888/zSound                                     * }
{ * https://github.com/PassByYou888/zChinese                                   * }
{ * https://github.com/PassByYou888/zExpression                                * }
{ * https://github.com/PassByYou888/zGameWare                                  * }
{ * https://github.com/PassByYou888/zAnalysis                                  * }
{ * https://github.com/PassByYou888/FFMPEG-Header                              * }
{ * https://github.com/PassByYou888/zTranslate                                 * }
{ * https://github.com/PassByYou888/InfiniteIoT                                * }
{ * https://github.com/PassByYou888/FastMD5                                    * }
{ ****************************************************************************** }
unit zSound;

{$INCLUDE ..\zDefine.inc}

interface

uses CoreClasses, MemoryStream64, UnicodeMixedLib,
  ObjectDataManager, ObjectDataHashField, PascalStrings, ListEngine;

type
  TzSound = class(TCoreClassPersistent)
  protected
    FSearchDB: TCoreClassObject;
    FTempPath: SystemString;
    FCacheFileList: THashVariantList;
    FLastPlaySoundFilename: SystemString;

    procedure DoPrepareMusic(FileName: SystemString); virtual; abstract;
    procedure DoPlayMusic(FileName: SystemString; Restart: boolean); virtual; abstract;
    procedure DoStopMusic; virtual; abstract;
    procedure DoPauseMusic; virtual; abstract;

    procedure DoPrepareAmbient(FileName: SystemString); virtual; abstract;
    procedure DoPlayAmbient(FileName: SystemString; Restart: boolean); virtual; abstract;
    procedure DoStopAmbient; virtual; abstract;
    procedure DoPauseAmbient; virtual; abstract;

    procedure DoPrepareSound(FileName: SystemString); virtual; abstract;
    procedure DoPlaySound(FileName: SystemString; Restart: boolean); virtual; abstract;
    procedure DoStopSound(FileName: SystemString); virtual; abstract;

    procedure DoStopAll; virtual; abstract;

    function DoIsPlaying(FileName: SystemString): boolean; virtual; abstract;

    function SaveSoundAsLocalFile(FileName: SystemString): SystemString; virtual;
    function SoundReadyOk(FileName: SystemString): boolean; virtual;
  public
    constructor Create(ATempPath: SystemString); virtual;
    destructor Destroy; override;

    procedure PrepareMusic(FileName: SystemString);
    procedure PlayMusic(FileName: SystemString; Restart: boolean);
    procedure StopMusic;
    procedure PauseMusic;

    procedure PrepareAmbient(FileName: SystemString);
    procedure PlayAmbient(FileName: SystemString; Restart: boolean);
    procedure StopAmbient;
    procedure PauseAmbient;

    procedure PrepareSound(FileName: SystemString);
    procedure PlaySound(FileName: SystemString; Restart: boolean);
    procedure StopSound(FileName: SystemString);

    procedure StopAll;

    procedure Progress(deltaTime: Double); virtual;

    property SearchDB: TCoreClassObject read FSearchDB write FSearchDB;
    property LastPlaySoundFilename: SystemString read FLastPlaySoundFilename;
  end;

  TSoundEngineClass = class of TzSound;

var
  DefaultSoundEngineClass: TSoundEngineClass;

implementation

uses MediaCenter;

function TzSound.SaveSoundAsLocalFile(FileName: SystemString): SystemString;
begin
  Result := FileName;
end;

function TzSound.SoundReadyOk(FileName: SystemString): boolean;
begin
  Result := False;
end;

constructor TzSound.Create(ATempPath: SystemString);
begin
  inherited Create;
  FSearchDB := nil;
  FTempPath := ATempPath;
  FCacheFileList := THashVariantList.Create;
  FLastPlaySoundFilename := '';
end;

destructor TzSound.Destroy;
begin
  DisposeObject(FCacheFileList);
  inherited Destroy;
end;

procedure TzSound.PrepareMusic(FileName: SystemString);
begin
  try
    if SoundReadyOk(FileName) then
      DoPrepareMusic(FileName)
    else
      DoPrepareMusic(SaveSoundAsLocalFile(FileName));
  except
  end;
end;

procedure TzSound.PlayMusic(FileName: SystemString; Restart: boolean);
begin
  try
    if SoundReadyOk(FileName) then
      DoPlayMusic(FileName, Restart)
    else
      DoPlayMusic(SaveSoundAsLocalFile(FileName), Restart);
  except
  end;
end;

procedure TzSound.StopMusic;
begin
  try
    DoStopMusic;
  except
  end;
end;

procedure TzSound.PrepareAmbient(FileName: SystemString);
begin
  try
    if SoundReadyOk(FileName) then
      DoPrepareAmbient(FileName)
    else
      DoPrepareAmbient(SaveSoundAsLocalFile(FileName));
  except
  end;
end;

procedure TzSound.PauseAmbient;
begin
  try
    DoPauseAmbient
  except
  end;
end;

procedure TzSound.PauseMusic;
begin
  try
    DoPauseMusic;
  except
  end;
end;

procedure TzSound.PlayAmbient(FileName: SystemString; Restart: boolean);
begin
  try
    if SoundReadyOk(FileName) then
      DoPlayAmbient(FileName, Restart)
    else
      DoPlayAmbient(SaveSoundAsLocalFile(FileName), Restart);
  except
  end;
end;

procedure TzSound.StopAmbient;
begin
  try
    DoStopAmbient
  except
  end;
end;

procedure TzSound.PrepareSound(FileName: SystemString);
begin
  try
    if SoundReadyOk(FileName) then
      DoPrepareSound(FileName)
    else
      DoPrepareSound(SaveSoundAsLocalFile(FileName));
  except
  end;
end;

procedure TzSound.PlaySound(FileName: SystemString; Restart: boolean);
begin
  try
    FLastPlaySoundFilename := FileName;
    if SoundReadyOk(FileName) then
    begin
      DoPlaySound(FileName, Restart);
    end
    else
      DoPlaySound(SaveSoundAsLocalFile(FileName), Restart);
  except
  end;
end;

procedure TzSound.StopSound(FileName: SystemString);
begin
  try
    if FCacheFileList.Exists(FileName) then
      DoStopSound(FCacheFileList[FileName])
    else if SoundReadyOk(FileName) then
      DoStopSound(FileName);
  except
  end;
end;

procedure TzSound.StopAll;
begin
  try
    DoStopAll;
  except
  end;
end;

procedure TzSound.Progress(deltaTime: Double);
begin
end;

initialization

DefaultSoundEngineClass := TzSound;

end.
