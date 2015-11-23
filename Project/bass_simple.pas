unit bass_simple;

// BassSimple Lite v1.8
// http://jqbook.narod.ru/delphi/bass.htm
// alexpac26@yandex.ru Тольятти 2012
// совместим Delphi

{
Для работы требуется
- Bass.pas
- bass.dll
}

{
Дополнительно плагины
- bass_aac.dll
- bassflac.dll
- basswma.dll
-> больше плагинов можно найти на официальном сайте
}

interface

uses
  SysUtils, Windows, Classes, bass ;

//  procedure upplay (BassObj: TObject);

const
  // константы состояний
   b_play = 1;
   b_stop = 0;
   b_notready = -1;
   b_pause = 2;
   // при инициализации использовать реальную частоту диксретизации устройства
   b_realrate = true;
   // разделитель строки времени
   b_time_rz = ':';
   // Музыкальные форматы
   b_file_standart1 = '*.mp3;*.mp2;*.mp1;*.ogg;*.wav;*.aiff';
   // Треки
   b_file_standart2 = '*.mo3;*.xm;*.mod;*.s3m;*.it;*.mtm;*.umx';
   // строки OpenDialog
   b_open_dialog_files0 = 'All Formats';
   b_open_dialog_files1 = 'Main(mp3 ogg wav aif)';
   b_open_dialog_files2 = 'Tracks(xm mod umx)';
   b_open_dialog_files3 = 'Other ';
   b_open_dialog_files_all = 'All Files|*.*';
   // текст радио лоадера
   b_timer_load = 'Loading ...';
   // строка безопасности плагинов не относящихся к форматам воспроизведения
   // названия файлов которые содержат этот фильтр НЕ будут загружены через BASS_PluginLoad
   b_private_plugins = 'x.dll|ow.dll|sp.dll|enc.dll';
   // если вы подключаете плагины типа BASS_ADX BASS_AIX которые оканчиваются на X, то
   // измените строку  b_private_plugins в нужную вам конфигурацию

   // BassSimple Messages
const

b_mess_error : array[0..1,0..3] of string =
  ( ('Unknown file type'#13#10,  // eng 0
      'File is not exists'#13#10,
     'Stream is not created'#13#10,
     'Play the Stream Error'#13#10 ),
     ('Неизвестный формат файла'#13#10,  // rus 1
      'Файл не найден'#13#10,
     'Не удалось создать поток'#13#10,
     'Не удалось запустить воспроизведение'#13#10 )
  );

type

  // зеркальный тип Bass_Info
  TBassInfo = Bass_Info;

  TBassLevel = record
    left: double;
    right: double;
  end;

type

   { TBassSimple }

   TBassSimple = class (TObject)
      private
        Rvolume: byte;
        function RSec: double;
        procedure Wsec(const Value: double);
        procedure Wvol(const Value: byte);
      protected
        Loaded:boolean;
        bassMemory: boolean;
        MemoryPointer: TMemoryStream;
	      Played:boolean;
	      Paused:boolean;
        Busy: boolean;
        bassRadio: boolean;
        Rfilename: string;
        ProcessPosition: double;
        ProcessState: integer;
        procedure Load;  virtual;
        procedure LoadTags; virtual;
      public
        // все радио заголовки Radio ICY считаются юникодными
        RadioTitleUnicode: boolean;
        // очистка потока при остановке
        FreeOnStop: boolean;
        // хендл окна
        Handle: HWND;
        // поток
        Stream: cardinal;
        // события
        OnEndPlay: TNotifyEvent;
        OnStop: TNotifyEvent;
        OnPlay: TNotifyEvent;
        OnFree: TNotifyEvent;
        OnReady: TNotifyEvent;
        OnChangePosition: TNotifyEvent;
        OnTitleChange: TNotifyEvent;
        // для серверов
        OnServerPlay: TNotifyEvent;
        OnServerStop: TNotifyEvent;
        // значения частот визуализаций
        Channel: TBassLevel;  { 0-1 }
        // ID тег
        IDv1Tag : TAG_ID3;
        // имя файла для отображения
        title : String;
        // процедуры аварийной остановки
        procedure ProcessPause;
        procedure ProcessContinue;
        // конструктор
        constructor Create(handle: HWND); virtual;
        destructor Destroy; override;
        // методы
        procedure Play(filename: string = ''); overload;
        procedure Play(Stream: TStream); overload;
        procedure OpenFile(filename: string = '');
        procedure OpenStream(Stream: TStream);
        procedure Stop; virtual;
        procedure Pause; virtual;
        procedure Reset; virtual;
        procedure FreeStream;
        function Status:integer;
        // уровень звука каналов для визуализаций
        procedure ChannelLevel(volume_calc: boolean = false);
        // звук
        function Channels: integer;
        function ChannelsText: string;
        function kbps: integer;
        function kHz: integer;
        // свойства времени
        function SecondsToBytes(sec: double): integer;
        function SecondsLength: double;
        function TimeLength: string;
        function TimePosition: string;
        property
          SecondsPosition: double read RSec write Wsec;
        property
          Volume: byte read Rvolume write Wvol;
        property
          filename: string read Rfilename;
        property
          Radio: boolean read bassRadio;
        property
          Memory: boolean read bassMemory;
   end;

TBassInitCustom = procedure (handle: HWND; realrate: boolean = false);

var
  BassInited: boolean;
  BassFloat : DWORD;
  BassUnicode: DWORD;
  BassOpenDialogFiles: string;
  BassPlayableFiles: string;
  BassFilePlugins: string;
  BassInitCustom : TBassInitCustom;
  b_mess_lang: byte;

function BassCheckFileExt(filename:string):boolean;
function BassErrorString(code: integer = - 7):string;
procedure BassSimpleInit(handle: HWND; realrate:boolean = false);
function SecondsToTime(sec: double): String;
// FindFilesInFolder('C:\Users\Lesha\Desktop\', 'bass*.dll', memo1.Lines);
procedure FindFilesInFolder(folder,mask:string; results: TStrings; addnew: boolean = false);
procedure winmessage(h: HWND; text,caption: string; messtype: integer = MB_ICONWARNING);
procedure BassSimpleFree;

implementation

function BassCheckFileExt(filename:string):boolean;
begin
  result:=(pos(LowerCase(ExtractFileExt(filename)),BassPlayableFiles)>0);
end;

procedure BassSimpleFree;
begin
  BassInited:=false;
  Bass_free;
end;

procedure winmessage(h: HWND; text,caption: string; messtype: integer);
begin
  MessageBox(h,PChar(text),PChar(caption),messtype);
end;

function SecondsToTime(sec: double): String;
var
  m, s: INTEGER;
begin
  s:=round(sec);
  m:=s div 60;
  if m<60 then result := Format('%.2d'+b_time_rz+'%.2d', [m, s mod 60])
  else result := Format('%.d'+b_time_rz+'%.2d'+b_time_rz+'%.2d', [m div 60, m mod 60, s mod 60]);
end;

{* FindFilesInFolder('C:\Users\Lesha\Desktop\', 'bass*.dll', memo1.Lines); *}
procedure FindFilesInFolder(folder,mask:string; results: TStrings; addnew: boolean);
var fd: TWin32FindData; fh: THandle;
begin
  if not addnew then results.Clear;
  fh := FindFirstFile(PChar(folder + mask), fd);
  if (fh <> INVALID_HANDLE_VALUE) then begin
    try
      repeat
        results.add(fd.cFileName);
      until not FindNextFile(fh, fd);
    finally
      Windows.FindClose(fh);
    end;
  end;
end;

procedure BassSimpleInitPlugins;
var plug: HPLUGIN; i,a,j: integer; ok: boolean; pluginlist: TStringList; BInfo: ^Bass_PluginInfo; pr_plug: TStringList;
begin
  BASS_SetConfig(BASS_CONFIG_NET_PLAYLIST, 1); // enable playlist processing
  BASS_SetConfig(BASS_CONFIG_NET_PREBUF, 25); // minimize automatic pre-buffering, so we can do it (and display it) instead
  // юникод
    {$IFDEF UNICODE} BassUnicode:=BASS_UNICODE; {$ELSE} BassUnicode:=0; {$ENDIF}
  // загузка плагинов
    Bassfileplugins:='';
    pluginlist:=TStringList.Create;
    pr_plug:=TStringList.Create;
    ExtractStrings(['|'],[' '],PChar(b_private_plugins),pr_plug);
    FindFilesInFolder(ExtractFilePath(ParamStr(0)), 'bass*.dll', pluginlist);
    for i := 0 to pluginlist.Count - 1 do begin
      ok:=true;
      for j := 0 to pr_plug.Count-1 do
      // проверка на то что плагин является системным и грузить его автоматически нельзя
        if pos(pr_plug[j],LowerCase(pluginlist[i]))>0 then begin
          ok:=false;
          break;
        end;
      if not ok then Continue;
      plug := BASS_PluginLoad(PChar(pluginlist[i]), BassUnicode);
      if Plug <> 0 then begin
         BInfo := pointer(BASS_PluginGetInfo(Plug));
         for a := 0 to BInfo.formatc - 1 do
           Bassfileplugins:=Bassfileplugins+';'+BInfo.Formats[a].exts;
      end;
    end;
    pr_plug.Free;
    pluginlist.free;
    // расчет строки Open Dialog
    Bassopendialogfiles:=
      b_open_dialog_files0 + '|' + b_file_standart1 +';' +b_file_standart2+';'+Bassfileplugins+'|'+
      b_open_dialog_files1 + '|' + b_file_standart1+'|'+
      b_open_dialog_files2 + '|' + b_file_standart2+'|'+
      b_open_dialog_files3 + '('+Bassfileplugins+')|' + Bassfileplugins +'|'+
      b_open_dialog_files_all;
    // расчет строки файлов
    BassPlayableFiles:= b_file_standart1 + ' ' + b_file_standart2 + ' ' + Bassfileplugins;
end;

procedure BassSimpleInit(handle: HWND; realrate:boolean);
var info: TBassInfo;
begin
  if not BassInited then begin
    // **********************
    bassfloat:=0;
     // check the correct BASS was loaded
    if (HiWord(BASS_GetVersion()) <> BASSVERSION) then begin
      raise Exception.Create('An incorrect version of BASS.DLL was loaded (2.4 is required)'); Halt;
    end;
    // **********************
    if @bassInitCustom<>nil then begin
      // **********************
      // Загрузчик BASS_SIMPLE CUSTOM 1.5
      bassInitCustom(handle,realrate)
    end else begin
      // **********************
      // Загрузчик BASS_SIMPLE LITE 1.5
      if not BASS_Init(-1, 44100, 0, handle, nil) then begin
        raise Exception.Create('BASS.DLL not Loaded!'#13+BassErrorString); Halt;
      end;
      if realrate then begin
        BASS_GetInfo(info);
        if (info.maxrate>44100) then begin
          Bass_free;
          // Initialize BASS with the default device
          if not BASS_Init(-1, info.maxrate, 0, handle, nil) then
            if not BASS_Init(-1, 44100, 0, handle, nil) then begin
               raise Exception.Create('BASS.DLL not Loaded!'#13+BassErrorString); Halt;
            end;
        end; // end if info.maxrate
      end; // end realrate
    end; // end custom init
    // **********************
    BassInited:=true;
    // Загрузка плагинов
    BassSimpleInitPlugins;
  end; // end init
end;

function BassErrorString(code: integer):string;
begin
  result:='';
  case code of
  BASS_OK : result:='BASS_OK';
  BASS_ERROR_MEM : result:='BASS_ERROR_MEM';          
  BASS_ERROR_FILEOPEN : result:='BASS_ERROR_FILEOPEN';     
  BASS_ERROR_DRIVER : result:='BASS_ERROR_DRIVER';
  BASS_ERROR_BUFLOST : result:='BASS_ERROR_BUFLOST';
  BASS_ERROR_HANDLE : result:='BASS_ERROR_HANDLE';       
  BASS_ERROR_FORMAT : result:='BASS_ERROR_FORMAT';
  BASS_ERROR_POSITION : result:='BASS_ERROR_POSITION';     
  BASS_ERROR_INIT : result:='BASS_ERROR_INIT';         
  BASS_ERROR_START : result:='BASS_ERROR_START';        
  BASS_ERROR_ALREADY : result:='BASS_ERROR_ALREADY';      
  BASS_ERROR_NOCHAN : result:='BASS_ERROR_NOCHAN';
  BASS_ERROR_ILLTYPE : result:='BASS_ERROR_ILLTYPE';      
  BASS_ERROR_ILLPARAM : result:='BASS_ERROR_ILLPARAM';     
  BASS_ERROR_NO3D : result:='BASS_ERROR_NO3D';         
  BASS_ERROR_NOEAX : result:='BASS_ERROR_NOEAX';        
  BASS_ERROR_DEVICE : result:='BASS_ERROR_DEVICE';       
  BASS_ERROR_NOPLAY : result:='BASS_ERROR_NOPLAY';       
  BASS_ERROR_FREQ : result:='BASS_ERROR_FREQ';         
  BASS_ERROR_NOTFILE : result:='BASS_ERROR_NOTFILE';      
  BASS_ERROR_NOHW : result:='BASS_ERROR_NOHW';         
  BASS_ERROR_EMPTY : result:='BASS_ERROR_EMPTY';        
  BASS_ERROR_NONET : result:='BASS_ERROR_NONET';        
  BASS_ERROR_CREATE : result:='BASS_ERROR_CREATE';       
  BASS_ERROR_NOFX : result:='BASS_ERROR_NOFX';         
  BASS_ERROR_NOTAVAIL : result:='BASS_ERROR_NOTAVAIL';     
  BASS_ERROR_DECODE : result:='BASS_ERROR_DECODE';       
  BASS_ERROR_DX : result:='BASS_ERROR_DX';           
  BASS_ERROR_TIMEOUT : result:='BASS_ERROR_TIMEOUT';      
  BASS_ERROR_FILEFORM : result:='BASS_ERROR_FILEFORM';     
  BASS_ERROR_SPEAKER : result:='BASS_ERROR_SPEAKER';      
  BASS_ERROR_VERSION : result:='BASS_ERROR_VERSION';      
  BASS_ERROR_CODEC : result:='BASS_ERROR_CODEC';        
  BASS_ERROR_ENDED : result:='BASS_ERROR_ENDED';
  BASS_ERROR_UNKNOWN : result:='BASS_ERROR_UNKNOWN';
  -7: begin result:= BassErrorString(BASS_ErrorGetCode); exit; end;
  end;
  result:= result + ' ('+inttostr(code)+')';
end;

// событие окончания воспроизведения
procedure Ch_EndPlay(handle: HSYNC; Stream, data: DWORD; user: Pointer); stdcall;
begin
  if @TBassSimple(user).OnServerStop<>nil then
     TBassSimple(user).OnServerStop(TBassSimple(user));
  TBassSimple(user).Stop;
  if @TBassSimple(user).OnEndPlay<>nil then
     TBassSimple(user).OnEndPlay(TBassSimple(user));
end;
// событие опустошения
procedure Ch_OnFree(handle: HSYNC; Stream, data: DWORD; user: Pointer); stdcall;
begin
  if @TBassSimple(user).OnServerStop<>nil then
     TBassSimple(user).OnServerStop(TBassSimple(user));
  TBassSimple(user).Loaded:=false;
  if @TBassSimple(user).OnFree<>nil then
     TBassSimple(user).OnFree(TBassSimple(user));
end;

// событие перемотки
procedure Ch_OnChangePosition(handle: HSYNC; Stream, data: DWORD; user: Pointer); stdcall;
begin
  if @TBassSimple(user).OnChangePosition<>nil then begin
     TBassSimple(user).OnChangePosition(TBassSimple(user));
  end;
  if not BASS_ChannelIsSliding(TBassSimple(user).Stream, BASS_ATTRIB_VOL) then
     TBassSimple(user).Volume:=TBassSimple(user).Rvolume;
end;

// событие определения заголовка радио станции
procedure Ch_MetaSync(handle: HSYNC; Stream, data: DWORD; user: Pointer); stdcall;
var
  meta: PAnsiChar;
  metaS: String;
  p: Integer;
begin
  meta := BASS_ChannelGetTags(Stream, BASS_TAG_META);
  With TBassSimple(user) do begin
    title:=filename;
    if Assigned(meta) then begin
      // Юникод это ГОСТ
      if TBassSimple(user).RadioTitleUnicode then
        metaS:=UTF8ToAnsi(StrPas(meta)) else metaS:=StrPas(meta);
      p := Pos('StreamTitle=', metaS);
      if (p = 0) then Exit;
      p := p + 13;
      title:=Copy(metaS, p, Pos(';', metaS)-15);
      if Length(trim(title))<2 then title:=filename;
    end;
  end;
  if @TBassSimple(user).OnTitleChange<>nil then
     TBassSimple(user).OnTitleChange(TBassSimple(user));
end;

{ TBassSimple }

// max 32768
procedure TBassSimple.ChannelLevel(volume_calc: boolean);
var level: dword; v: single;
begin
  Channel.left:=0;
  Channel.right:=0;
  if Played then begin
    level:=BASS_ChannelGetLevel(self.stream);
    v:=1;
    if volume_calc then v:=self.Volume/100;
    Channel.left:=v*LOWORD(level)/32768;
    Channel.right:=v*HIWORD(level)/32768;
  end;
end;

function TBassSimple.Channels: integer;
Var CHANINFO : BASS_CHANNELINFO;
begin
  result:=0;
  if Status<0 then exit;
  BASS_ChannelGetInfo(stream, CHANINFO);
  result:=round(CHANINFO.chans);
end;

function TBassSimple.ChannelsText: string;
var c: integer;
begin
  result:='';
  c:=Channels;
  case c of
    1: result:='mono';
    else result:='stereo';
  end;
end;

constructor TBassSimple.Create(handle: HWND);
begin
  Loaded:=false;
  BassSimpleInit(handle,b_realrate);
  ProcessPosition:=-1;
  ProcessState:=-1;
  self.Handle:=Handle;
  RadioTitleUnicode:=true;
  FreeOnStop:=true;
  Stream:=0;
  Rvolume:=100;
  Reset;
end;

destructor TBassSimple.Destroy;
begin
  Reset;
  inherited;
end;

function TBassSimple.kbps: integer;
begin
  result:=0;
	if not Loaded then exit;
	result:=trunc((
      BASS_StreamGetFilePosition(stream, BASS_FILEPOS_END)/
      (125*BASS_ChannelBytes2Seconds(stream, BASS_ChannelGetLength(stream,BASS_POS_BYTE)))
    )+0.5); // bitrate (Kbps)
end;

function TBassSimple.kHz: integer;
Var CHANINFO : BASS_CHANNELINFO;
begin
	result:=0;
	if not Loaded then exit;
  BASS_ChannelGetInfo(stream, CHANINFO);
  result := round(CHANINFO.freq);
end;

function BassFileExtract(filename: string; var ext, url: string):boolean;
begin
  result:=false;
  if length(filename)<4 then exit;
  url:=LowerCase(Copy(filename,1,4));
  ext:=LowerCase(ExtractFileExt(filename));
  result:=true;
end;

procedure TBassSimple.Load;
var url,ext:String;
// BassSimple Loader 1.7
begin
// загрузчик
if busy then exit;
FreeStream;
busy:=true;
Loaded:=false;
bassRadio:=false;
if bassMemory then begin
  // загружаем через память
  stream := BASS_StreamCreateFile(true,MemoryPointer.Memory,0,MemoryPointer.Size, bassfloat);
end else begin
  if not BassFileExtract(filename,ext, url) then begin
    busy:=false;
    exit;
  end;
// определение типа файла
// сетевой ресурс
if (pos('http',url)>0) {or (pos('ftp',url)>0)} {ftp не нужен ИМХО} then begin
   title:=b_timer_load;
   bassRadio:=true;
   if @OnTitleChange<>nil then OnTitleChange(self);
   stream := BASS_StreamCreateURL(PAnsiChar(AnsiString(filename)), 0, bassfloat or BASS_STREAM_AUTOFREE, nil, nil);
   Ch_MetaSync(Handle,Stream,0,self);
// файл на диске
end else if FileExists(filename) then begin
// определение файла на диске
   //*.mo3;*.xm;*.mod;*.s3m;*.it;*.mtm
   if pos(ext,b_file_standart2)>0 then
      stream := BASS_MusicLoad(False,PChar(filename),0,0,BASS_MUSIC_PRESCAN or BassUnicode,0)
   // плагины + файлы
   else if pos(ext,b_file_standart1+Bassfileplugins)>0 then
      stream := BASS_StreamCreateFile(False,PChar(filename),0,0, bassfloat or BassUnicode)
   else begin
      winmessage(Handle,b_mess_error[b_mess_lang,0]+filename,'Error');
      busy:=false; exit;
   end;
end else begin // end FileExists
   winmessage(Handle,b_mess_error[b_mess_lang,1]+filename,'Error');
   busy:=false; exit;
end;
end; // end if memory
// запуск завершен
if (stream = 0) then begin
   winmessage(Handle,b_mess_error[b_mess_lang,2]+BassErrorString,'Error BASS_StreamCreateFile');
   busy:=false; exit;
end;
busy:=false;
Loaded:=true;
Volume:=Rvolume;
// ** загрузка выполнена!
// установка событий
BASS_ChannelSetSync(Stream, BASS_SYNC_END,0,@Ch_EndPlay,self);
if not Radio then BASS_ChannelSetSync(Stream, BASS_SYNC_SETPOS,0,@Ch_OnChangePosition,self);
BASS_ChannelSetSync(Stream, BASS_SYNC_FREE,0,@Ch_OnFree,self);
// загрузка тегов
if not bassMemory then LoadTags;
// выполнение действий
if @OnReady<>nil then OnReady(self);
if bassMemory then exit;
if @OnTitleChange<>nil then begin
    if Radio then BASS_ChannelSetSync(Stream, BASS_SYNC_META,0,@Ch_MetaSync,self);
    OnTitleChange(self);
end;
end;


procedure TBassSimple.LoadTags;
type
  PTAG_ID3 = ^TAG_ID3;
var
  TagStr: PAnsiChar;
begin
  TagStr:=BASS_ChannelGetTags(self.Stream,BASS_TAG_ID3);
  FillChar(IDv1Tag, SizeOf(IDv1Tag), #0);
  if not Radio then begin
    if Assigned(TagStr) then begin
      IDv1Tag:=PTAG_ID3( BASS_ChannelGetTags(self.Stream,BASS_TAG_ID3) )^;
      if (length(trim(IDv1Tag.artist))>1) and (length(trim(IDv1Tag.title))>1) then begin
        title:=trim(IDv1Tag.artist)+' - '+trim(IDv1Tag.title);
      end else
        title:=ExtractFileName(filename);
    end else begin
      IDv1Tag.id:='non';
      title:=ExtractFileName(filename);
    end;
  end;
  // end if bassRadio
end;

procedure TBassSimple.OpenFile(filename: string);
begin
  if filename<>'' then bassMemory:=false;
  if bassMemory then exit;
  if length(filename)<3 then begin
    if (not Loaded) and (length(Rfilename)>3) then Load;
    exit;
  end;
  if (not Loaded) OR ( self.Rfilename<>filename ) then begin
    self.Rfilename:=filename;
    Load;
  end;
end;

procedure TBassSimple.OpenStream(Stream: TStream);
begin
  MemoryPointer:=TMemoryStream(Stream);
  bassMemory:=true;
  Load;
end;

procedure TBassSimple.Pause;
begin
  if not Loaded then exit;
  if Paused then Play else begin
     if @OnServerStop<>nil then OnServerStop(self);
     BASS_ChannelPause(stream);
     Paused:=true;
	   Played:=false;
  end;
end;

procedure TBassSimple.Play(Stream: TStream);
begin
  OpenStream(Stream);
  Play;
end;

procedure TBassSimple.Play(filename: string);
begin
  OpenFile(filename);
  if not Loaded then exit;
  if not BASS_ChannelPlay(stream, not Paused) then begin
    winMessage(Handle,b_mess_error[b_mess_lang,3]+#13#10+BassErrorString,'Error Play');
    exit;
  end;
  Paused:=false;
  Played:=true;
  if @OnPlay<>nil then OnPlay(self);
  if @OnServerPlay<>nil then OnServerPlay(self);
end;

procedure TBassSimple.ProcessContinue;
begin
  if (not Loaded) then begin
    if ProcessPosition>=0 then begin
      Load;
      if Loaded and (not Radio) then begin
        SecondsPosition:=ProcessPosition;
        Paused:=true;
        if ProcessState=b_play then Play;
      end;
    end;
  end;
end;

procedure TBassSimple.ProcessPause;
begin
  if (not Loaded) or (Radio) then ProcessPosition:=-1 else begin
    ProcessPosition:=self.SecondsPosition;
    ProcessState:=Status;
  end;
  FreeStream;
end;

procedure TBassSimple.Reset;
begin
  Loaded:=false;
  Played:=false;
  Paused:=false;
  Rfilename:='';
  FreeStream;
end;

procedure TBassSimple.FreeStream;
begin
if busy then exit;
if @OnServerStop<>nil then OnServerStop(self);
Loaded:=false;
if stream<>0 then begin
	Played:=false;
	Paused:=false;
	BASS_ChannelStop(stream);
	BASS_StreamFree(stream);
	stream:=0;
end;
end;

function TBassSimple.RSec: double;
begin
  result:=0;
	if not Loaded then exit;
  result:=BASS_ChannelBytes2Seconds(stream,
    BASS_ChannelGetPosition(stream,BASS_POS_BYTE)
  );
end;

function TBassSimple.SecondsLength: double;
begin
  result:=0;
	if not Loaded then exit;
	result:=BASS_ChannelBytes2Seconds(
    stream,
    BASS_ChannelGetLength( stream, BASS_POS_BYTE )
  );
end;

function TBassSimple.SecondsToBytes(sec: double): integer;
begin
  result:=0;
  if not Loaded then exit;
  result:=BASS_ChannelSeconds2Bytes(stream,sec);
end;

function TBassSimple.Status: integer;
begin
  if not Loaded then begin result:=-1; exit; end;
  result:=0;
  if Played then result:=1;
  if Paused then result:=2;
end;

procedure TBassSimple.Stop;
begin
  if not Loaded then exit;
  bassRadio:=false;
  BASS_ChannelStop(stream);
	SecondsPosition:=0;
  Paused:=false;
  Played:=false;
  if @OnStop<>nil then OnStop(self);
  if self.FreeOnStop then self.FreeStream;
end;

function TBassSimple.TimeLength: string;
begin
  result:=SecondsToTime(SecondsLength);
end;

function TBassSimple.TimePosition: string;
begin
  result:=SecondsToTime(SecondsPosition);
end;

procedure TBassSimple.Wsec(const Value: double);
begin
if not Loaded then exit;
  BASS_ChannelSetPosition(
    stream,
    BASS_ChannelSeconds2Bytes(stream,Value),
    BASS_POS_BYTE
  );
end;

procedure TBassSimple.Wvol(const Value: byte);
begin
 Rvolume:=value;
 if Rvolume>100 then Rvolume:=100;
 if not Loaded then exit;
 BASS_ChannelSetAttribute(stream, BASS_ATTRIB_VOL, Rvolume/100);
end;

initialization

b_mess_lang:=1; // русский
//b_mess_lang:=0; // английский
BassInited:=false;

end.
