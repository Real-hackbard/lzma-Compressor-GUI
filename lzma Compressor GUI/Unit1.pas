unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, WinApi.ShellAPI, System.IniFiles,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label5: TLabel;
    CheckBox12: TCheckBox;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button3: TButton;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Edit2: TEdit;
    Button4: TButton;
    Button5: TButton;
    Label7: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label8: TLabel;
    GroupBox3: TGroupBox;
    ScrollBar1: TScrollBar;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Edit3: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    OpenDialog2: TOpenDialog;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1: TForm1;
  app: String;
  TIF : TIniFile;

implementation

{$R *.dfm}

// get application MainPath
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
    WriteBool(OPT,'Keep',CheckBox1.Checked);
    WriteBool(OPT,'Force',CheckBox2.Checked);
    WriteBool(OPT,'Backup',CheckBox3.Checked);
    WriteBool(OPT,'IgnoreException',CheckBox4.Checked);
    WriteBool(OPT,'Console',CheckBox12.Checked);
    WriteInteger(OPT,'Cores',ComboBox1.ItemIndex);
    WriteInteger(OPT,'Priority',ComboBox2.ItemIndex);
    WriteInteger(OPT,'CompressLevel', Scrollbar1.Position);
    Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var
  OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
    TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
    with TIF do
    begin
      CheckBox1.Checked:=ReadBool(OPT,'Keep',CheckBox1.Checked);
      CheckBox2.Checked:=ReadBool(OPT,'Force',CheckBox2.Checked);
      CheckBox3.Checked:=ReadBool(OPT,'Backup',CheckBox3.Checked);
      CheckBox4.Checked:=ReadBool(OPT,'IgnoreException',CheckBox4.Checked);
      CheckBox12.Checked:=ReadBool(OPT,'Console',CheckBox12.Checked);
      Combobox1.ItemIndex:=ReadInteger(OPT,'Cores',ComboBox1.ItemIndex);
      Combobox2.ItemIndex:=ReadInteger(OPT,'Priority',ComboBox2.ItemIndex);
      Scrollbar1.Position:=ReadInteger(OPT,'CompressLevel',Scrollbar1.Position);
      Free;
    end;
  end;
end;

procedure CallDynamicDLL;
type
  // Define a procedural type that matches the DLL function's signature
  TShowMessageFunc = procedure(const Msg: PAnsiChar); stdcall;
var
  DLLHandle: HMODULE;
  ShowMessageFunc: TShowMessageFunc;
begin
  // 1. Load the DLL into memory
  DLLHandle := LoadLibrary(PChar(MainDir + 'Data\lzma\lzma.dll'));
  if DLLHandle <> 0 then
  begin
    try
      // 2. Fetch the memory address of the exported function
      //@ShowMessageFunc := GetProcAddress(DLLHandle, 'Lzma2Enc_Create');
      GetProcAddress(DLLHandle, 'Lzma2Enc_Create');

      if Assigned(ShowMessageFunc) then
      begin
        // 3. Safely execute the function
        //ShowMessageFunc('Hello from dynamically loaded DLL!');
      end
      else
      begin
        RaiseLastOSError; // Function name not found in the DLL
      end;
    finally
      // 4. Always free the library when you are done to prevent memory leaks
      FreeLibrary(DLLHandle);
    end;
  end;
end;

// compress level setting bar
procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Label10.Caption := 'Level  : ' + IntToStr(ScrollBar1.Position);
end;

// Start the help message process and wait until it is finished.
procedure ExecuteHelpmessageAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;          // command line
  ExitCode: Cardinal;       // Safely closing the console
  SelectedPriority: DWORD;  // priority class
  ProgramPath: string;
begin
  // Read the selected flag from the ComboBox objects.
  SelectedPriority := DWORD(Form1.ComboBox2.Items.Objects[Form1.ComboBox2.ItemIndex]);

  // Assemble help message command line
  CmdLine := Format('cmd.exe /k "%s" %s', [FileName, Parameters]);

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  // show or hide console
  StartupInfo.wShowWindow := SW_NORMAL;

  // Create process
  if CreateProcess(
    nil,                       // Module name (use 'nil' and command in CmdLine)
    PChar(CmdLine),            // Command line
    nil,                       // Process safety attributes
    nil,                       // Thread safety attributes
    False,                     // Handle inheritance
    SelectedPriority,          // Creation flags (starts in a new console window)
    nil,                       // New environment specification block
    nil,                       // Current Directory
    StartupInfo,               // STARTUP INFO
    ProcessInfo) then          // PROCESS INFORMATION
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Optional: Retrieve and display the process exit code.
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    // Throws an error if the process could not be started.
    RaiseLastOSError;
end;

// Start the decompression process and wait until it is finished.
procedure ExecuteDecompressAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;          // command line
  ExitCode: Cardinal;       // Safely closing the console
  SelectedPriority: DWORD;  // priority class
  ProgramPath: string;
begin
  // Read the selected flag from the ComboBox objects.
  SelectedPriority := DWORD(Form1.ComboBox2.Items.Objects[Form1.ComboBox2.ItemIndex]);

  // Assemble command line
  CmdLine := Format('"%s" %s', [FileName, Parameters]);

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  // show or hide console
  if Form1.CheckBox12.Checked = true then
  begin
    StartupInfo.wShowWindow := SW_NORMAL;
  end else begin
    StartupInfo.wShowWindow := SW_HIDE;
  end;

  // Create process
  if CreateProcess(
    nil,                       // Module name (use 'nil' and command in CmdLine)
    PChar(CmdLine),            // Command line
    nil,                       // Process safety attributes
    nil,                       // Thread safety attributes
    False,                     // Handle inheritance
    SelectedPriority,          // Creation flags (starts in a new console window)
    nil,                       // New environment specification block
    nil,                       // Current Directory
    StartupInfo,               // STARTUP INFO
    ProcessInfo) then          // PROCESS INFORMATION
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Optional: Retrieve and display the process exit code.
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    // Throws an error if the process could not be started.
    RaiseLastOSError;
end;

// Start the compression process and wait until it is finished.
procedure ExecuteAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;          // command line
  ExitCode: Cardinal;       // Safely closing the console
  SelectedPriority: DWORD;  // priority class
  ProgramPath: string;
begin
  // Read the selected flag from the ComboBox objects.
  SelectedPriority := DWORD(Form1.ComboBox2.Items.Objects[Form1.ComboBox2.ItemIndex]);

  // Assemble command line
  if (Form1.CheckBox4.Checked = true) then
  begin
    CmdLine := Format('cmd.exe /k "%s" %s', [FileName, Parameters]);
  end else begin
    CmdLine := Format('"%s" %s', [FileName, Parameters]);
  end;

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  // show or hide console
  if Form1.CheckBox12.Checked = true then
  begin
    StartupInfo.wShowWindow := SW_NORMAL;
  end else begin
    StartupInfo.wShowWindow := SW_HIDE;
  end;

  // Create process
  if CreateProcess(
    nil,                       // Module name (use 'nil' and command in CmdLine)
    PChar(CmdLine),            // Command line
    nil,                       // Process safety attributes
    nil,                       // Thread safety attributes
    False,                     // Handle inheritance
    SelectedPriority,          // Creation flags (starts in a new console window)
    nil,                       // New environment specification block
    nil,                       // Current Directory
    StartupInfo,               // STARTUP INFO
    ProcessInfo) then          // PROCESS INFORMATION
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Optional: Retrieve and display the process exit code.
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    // Throws an error if the process could not be started.
    RaiseLastOSError;
end;

// precise determination of the file size
function Get_File_Size(const S: string): Int64;
var
  FD: TWin32FindData;
  FH: THandle;
begin
  // check if file exists
  FH := FindFirstFile(PChar(S), FD);
  // check file handle ist value
  if FH = INVALID_HANDLE_VALUE then Result := 0
  else
    try
      Result := FD.nFileSizeHigh;
      Result := Result shl 32;
      Result := Result + FD.nFileSizeLow;
    finally
      //CloseHandle(FH);
    end;
end;

// start compress operation
procedure TForm1.Button2Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  // clear parameter string
  Label3.Caption := '';

  // parameter flags
  // keep original files unchaned
  if CheckBox1.Checked = true then Label3.Caption := Label3.Caption + ' -k';
  // force overwrite of output file
  if CheckBox2.Checked = true then Label3.Caption := Label3.Caption + ' -f';
  // number of cores to use for parallelization (default 1)
  Label3.Caption := Label3.Caption + ' -cores ' + ComboBox1.Text;
  // compression level setting
  Label3.Caption := Label3.Caption + ' -l ' + IntToStr(ScrollBar1.Position);
  // use provided suffix on compressed files (default "lzma")
  Label3.Caption := Label3.Caption + ' -s ' + Edit3.Text;

  // write on standard output, keep original files unchanged
  if CheckBox4.Checked = true then
  begin
    Label3.Caption := '';
    // Determine the path to "lzma.exe".
    app := ExtractFilePath(Application.ExeName)+'Data\lzma\lzma.exe';
    ExecuteHelpMessageAndWait(PChar(app), PChar(' -c ' + Edit1.Text));
    Screen.Cursor := crDefault;
    Exit;    // go out after report
  end;

  // print this help message only
  if CheckBox3.Checked = true then
  begin
    Label3.Caption := '';

    // Determine the path to "lzma.exe".
    app := ExtractFilePath(Application.ExeName)+'Data\lzma\lzma.exe';
    StatusBar1.Panels[5].Text := 'Help message';

    // update program
    Application.ProcessMessages;

    // Start the compression process and wait until it is finished.
    ExecuteHelpMessageAndWait(PChar(app), PChar(' -h '));
    Screen.Cursor := crDefault;
    StatusBar1.SetFocus;
    Exit;   // go out after report
  end;

  // If not, continue. >>

  // Determine the path to "lzma.exe".
  app := ExtractFilePath(Application.ExeName)+'Data\lzma\lzma.exe';
  StatusBar1.Panels[5].Text := 'wait, compressing';

  // update program
  Application.ProcessMessages;

  // Start the compression process and wait until it is finished.
  ExecuteAndWait(PChar(app), PChar(Label3.Caption + ' ' + '"' + Edit1.Text + '"'));
  // report the new file size

  StatusBar1.Panels[5].Text := 'done.';
  // display compressed file size
  StatusBar1.Panels[3].Text := IntToStr(Get_File_Size(Edit1.Text + '.' + Edit3.Text) div 1000) + ' kb';
  Screen.Cursor := crDefault;
  StatusBar1.SetFocus;
end;

// load file to compress
procedure TForm1.Button3Click(Sender: TObject);
begin
   If OpenDialog1.Execute then
    begin
      Edit1.Text := OpenDialog1.FileName;
      Edit2.Clear;
      Button2.Enabled := true;
      Button5.Enabled := false;
      StatusBar1.Panels[3].Text :=  '0 kb';
      Edit3.Enabled := true;
      // display file size
      StatusBar1.Panels[1].Text := IntToStr(Get_File_Size(OpenDialog1.FileName) div 1000) + ' kb';
    end;
    StatusBar1.SetFocus;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  s : string;
begin
  if OpenDialog2.Execute then
  begin
    Edit2.Text := OpenDialog2.FileName;
    Edit1.Clear;
    // get ext. from loaded file
    s := ExtractFileExt(OpenDialog2.FileName);
    // Remove the dot from the suffix.
    s := Copy(s, 2 ,length(s));
    // display new suffix
    Edit3.Text := s;

    Button2.Enabled := false;
    Button5.Enabled := true;
    StatusBar1.Panels[3].Text :=  '0 kb';
    Edit3.Enabled := false;
    // display file size
    StatusBar1.Panels[1].Text := IntToStr(Get_File_Size(OpenDialog2.FileName) div 1000) + ' kb';
  end;
  StatusBar1.SetFocus;
end;

// start decompress operation
procedure TForm1.Button5Click(Sender: TObject);
var
  s, path : string;
  i : Integer;
  hist: array[byte] of Integer;
begin
  // clear parameter string
  Label3.Caption := '';

  // Determine the path to "lzma.exe".
  app := ExtractFilePath(Application.ExeName)+'Data\lzma\lzma.exe';

  StatusBar1.Panels[5].Text := 'wait, decompressing';
  // update form
  Application.ProcessMessages;

  // Start the decompression process and wait until it is finished.
  { DON'T FORGET!
    The 's' stands for the suffix used for the decompression process
    and is automatically detected. }
  ExecuteDecompressAndWait(PChar(app), PChar(' -d -s ' + Edit3.Text + ' ' + '"' + Edit2.Text + '"'));

  // get suffix
  s := Edit3.Text;
  // count suffix and copy it to "i"
  for i := 1 to Length(s) do
  begin
    inc(hist[Ord(s[i])]);
  end;

  // get path from loaded file
  path := OpenDialog2.FileName;
  // Remove the dot & ext. from the suffix "i".
  path := Copy(path, 1 ,length(path)-i);
  // display decompressed file size
  StatusBar1.Panels[3].Text := IntToStr(Get_File_Size(path) div 1000) + ' kb';
  StatusBar1.Panels[5].Text := 'finish.';
end;

// write on standard output, keep original files unchanged
procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked = true then
  begin
    Button5.Enabled := false;
    Button2.Caption := 'Help Message';
  end else begin
    Button5.Enabled := true;
    Button2.Caption := 'Compress';
  end;
end;

// Enables compressed data output in the console.
procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked = true then
  begin
    Button5.Enabled := false;
    Button2.Caption := 'Get Data';
  end else begin
    Button5.Enabled := true;
    Button2.Caption := 'Compress';
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : integer;
begin
  StatusBar1.Panels[5].Text := 'lzma.exe found!';

  // check if mpress.exe exists
  if not FileExists(MainDir + 'Data\lzma\lzma.exe') then
  begin
    MessageDlg('Error "lzma.exe" not found, check Folder ..\Data\lzma\..' +Chr(10)+
               'Download "lzma.exe" if not found.'
               ,mtWarning, [mbOK], 0);
    Label4.Font.Color := clMaroon;
    Label4.Caption := 'The program requires lzma.exe, which was not found.';
    Button3.Enabled := false;
    Button4.Enabled := false;
    StatusBar1.Panels[5].Text := 'lzma.exe not found!';
  end;

  // load "lzma.dll" in to the memory
  CallDynamicDLL;

  // Prevents free text input
  ComboBox2.Style := csDropDownList;
  // Link names and the corresponding WinAPI constants
  ComboBox2.AddItem('Idle (Low)', TObject(IDLE_PRIORITY_CLASS));
  // Manually defined for older Delphi versions, if applicable.
  ComboBox2.AddItem('Below Normal', TObject($00004000));
  ComboBox2.AddItem('Normal', TObject(NORMAL_PRIORITY_CLASS));
  // Manually defined if necessary
  ComboBox2.AddItem('Above Normal', TObject($00008000));
  ComboBox2.AddItem('High (Process)', TObject(HIGH_PRIORITY_CLASS));
  ComboBox2.AddItem('Realtime (Real-Time)', TObject(REALTIME_PRIORITY_CLASS));
  // Select 'Normal' by default (index 4)
  ComboBox2.ItemIndex := 4;

  Application.HintPause := 0;
  Application.HintHidePause := 50000;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
end;

end.
