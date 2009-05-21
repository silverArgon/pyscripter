{-----------------------------------------------------------------------------
 Unit Name: dmCommands
 Author:    Kiriakos Vlahos
 Date:      09-Mar-2005
 Purpose:   Data Module of PyScripter
 History:
-----------------------------------------------------------------------------}

unit dmCommands;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, SynEdit, SynEditHighlighter, SynHighlighterPython, SynRegExpr,
  ImgList, dlgSynEditOptions, SynEditPrint, StdActns,
  SynCompletionProposal, TB2Item,
  SynEditRegexSearch, SynEditMiscClasses, SynEditSearch, VirtualTrees,
  SynEditTextBuffer, SynEditKeyCmds, JvComponentBase, 
  JvProgramVersionCheck, JvPropertyStore,
  SynHighlighterIni, uEditAppIntfs, SynUnicode,
  JvStringHolder, cPyBaseDebugger, TntDialogs, TntLXDialogs,
  SynEditTypes, VirtualExplorerTree, VirtualShellNotifier, SynHighlighterWeb,
  SynHighlighterCpp, TntStdActns, TntActnList, SynHighlighterYAML, WideStrings,
  SpTBXTabs;

type
{$METHODINFO ON}
  TPythonIDEOptions = class(TPersistent)
  private
    fTimeOut : integer;
    fUndoAfterSave : Boolean;
    fSaveFilesBeforeRun : Boolean;
    fSaveEnvironmentBeforeRun : Boolean;
    fRestoreOpenFiles : Boolean;
    fCreateBackupFiles : Boolean;
    fExporerInitiallyExpanded : Boolean;
    fSearchTextAtCaret : Boolean;
    fPythonFileFilter : string;
    fHTMLFileFilter : string;
    fXMLFileFilter : string;
    fCSSFileFilter : string;
    fCPPFileFilter : string;
    fYAMLFileFilter : string;
    fFileExplorerFilter : string;
    fDateLastCheckedForUpdates : TDateTime;
    fAutoCheckForUpdates : boolean;
    fDaysBetweenChecks : integer;
    fMaskFPUExceptions : boolean;
    fSpecialPackages : WideString;
    fUTF8inInterpreter : boolean;
    fShowCodeHints : boolean;
    fShowDebuggerHints : boolean;
    fAutoCompleteBrackets : boolean;
    fCommandLine : WideString;
    fUseCommandLine : Boolean;
    fMarkExecutableLines : Boolean;
    fCheckSyntaxAsYouType : Boolean;
    fFileExplorerContextMenu : Boolean;
    fNewFileLineBreaks : TSynEditFileFormat;
    fNewFileEncoding : TFileSaveFormat;
    fDetectUTF8Encoding: Boolean;
    fEditorsTabPosition : TSpTBXTabPosition;
    fPythonEngineType : TPythonEngineType;
    fPrettyPrintOutput : Boolean;
    fSmartNextPrevPage : Boolean;
    fAutoReloadChangedFiles : Boolean;
    fClearOutputBeforeRun : Boolean;
    fAutoHideFindToolbar : Boolean;
    fCodeCompletionListSize : integer;
    fEditorCodeCompletion : Boolean;
    fInterpreterCodeCompletion : Boolean;
    fShowTabCloseButton : Boolean;
    fPostMortemOnException : Boolean;
    fDockAnimationInterval : integer;
    fDockAnimationMoveWidth : integer;
    fInterpreterHistorySize : integer;
    fSaveInterpreterHistory : Boolean;
    function GetPythonFileExtensions: string;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property PythonFileExtensions : string read GetPythonFileExtensions;
  published
    procedure Changed;
    property TimeOut : integer read fTimeOut write fTimeOut;
    property UndoAfterSave : boolean read fUndoAfterSave
      write fUndoAfterSave;
    property SaveFilesBeforeRun : boolean read fSaveFilesBeforeRun
      write fSaveFilesBeforeRun;
    property SaveEnvironmentBeforeRun : boolean read fSaveEnvironmentBeforeRun
      write fSaveEnvironmentBeforeRun;
    property RestoreOpenFiles : Boolean read fRestoreOpenFiles
      write fRestoreOpenFiles;
    property CreateBackupFiles : boolean read fCreateBackupFiles
      write fCreateBackupFiles;
    property ExporerInitiallyExpanded : boolean read fExporerInitiallyExpanded
      write fExporerInitiallyExpanded;
    property SearchTextAtCaret : Boolean read fSearchTextAtCaret
      write fSearchTextAtCaret stored False;
    property PythonFileFilter : string read fPythonFileFilter
      write fPythonFileFilter;
    property HTMLFileFilter : string read fHTMLFileFilter
      write fHTMLFileFilter;
    property XMLFileFilter : string read fXMLFileFilter
      write fXMLFileFilter;
    property CSSFileFilter : string read fCSSFileFilter
      write fCSSFileFilter;
    property CPPFileFilter : string read fCPPFileFilter
      write fCPPFileFilter;
    property YAMLFileFilter : string read fYAMLFileFilter
      write fYAMLFileFilter;
    property FileExplorerFilter : string read fFileExplorerFilter
      write fFileExplorerFilter;
    property DateLastCheckedForUpdates : TDateTime read fDateLastCheckedForUpdates
      write fDateLastCheckedForUpdates;
    property AutoCheckForUpdates : boolean read fAutoCheckForUpdates
      write fAutoCheckForUpdates;
    property DaysBetweenChecks : integer read fDaysBetweenChecks
      write fDaysBetweenChecks;
    property MaskFPUExceptions : Boolean read fMaskFPUExceptions
      write fMaskFPUExceptions;
    property SpecialPackages : WideString read fSpecialPackages write fSpecialPackages;
    property UTF8inInterpreter : boolean read fUTF8inInterpreter
      write fUTF8inInterpreter;
    property ShowCodeHints : boolean read fShowCodeHints write fShowCodeHints;
    property ShowDebuggerHints : boolean
      read fShowDebuggerHints write fShowDebuggerHints;
    property AutoCompleteBrackets : boolean
      read fAutoCompleteBrackets write fAutoCompleteBrackets;
    property CommandLine : WideString read fCommandLine write fCommandLine;
    property UseCommandLine : Boolean read fUseCommandLine write fUseCommandLine;
    property MarkExecutableLines : Boolean read fMarkExecutableLines
      write fMarkExecutableLines;
    property CheckSyntaxAsYouType : Boolean read fCheckSyntaxAsYouType
      write fCheckSyntaxAsYouType;
    property FileExplorerContextMenu : Boolean read fFileExplorerContextMenu
      write fFileExplorerContextMenu;
    property NewFileLineBreaks : TSynEditFileFormat read fNewFileLineBreaks
      write fNewFileLineBreaks;
    property NewFileEncoding : TFileSaveFormat read fNewFileEncoding write fNewFileEncoding;
    property DetectUTF8Encoding : Boolean read fDetectUTF8Encoding
      write fDetectUTF8Encoding;
    property EditorsTabPosition : TSpTBXTabPosition read fEditorsTabPosition
      write fEditorsTabPosition;
    property PythonEngineType : TPythonEngineType read fPythonEngineType
      write fPythonEngineType;
    property PrettyPrintOutput : Boolean read fPrettyPrintOutput write fPrettyPrintOutput;
    property SmartNextPrevPage : Boolean read fSmartNextPrevPage write fSmartNextPrevPage;
    property AutoReloadChangedFiles : Boolean read fAutoReloadChangedFiles
      write fAutoReloadChangedFiles;
    property ClearOutputBeforeRun : Boolean read fClearOutputBeforeRun
      write fClearOutputBeforeRun;
    property AutoHideFindToolbar : Boolean read fAutoHideFindToolbar
      write fAutoHideFindToolbar;
    property EditorCodeCompletion : Boolean read fEditorCodeCompletion
      write fEditorCodeCompletion;
    property InterpreterCodeCompletion : Boolean read fInterpreterCodeCompletion
      write fInterpreterCodeCompletion;
    property CodeCompletionListSize : integer read fCodeCompletionListSize
      write fCodeCompletionListSize;
    property ShowTabCloseButton : Boolean read fShowTabCloseButton
      write fShowTabCloseButton;
    property PostMortemOnException : Boolean read fPostMortemOnException
      write fPostMortemOnException;
    property DockAnimationInterval : integer read fDockAnimationInterval
      write fDockAnimationInterval;
    property DockAnimationMoveWidth : integer read fDockAnimationMoveWidth
      write fDockAnimationMoveWidth;
    property InterpreterHistorySize : integer read fInterpreterHistorySize
      write fInterpreterHistorySize;
    property SaveInterpreterHistory : Boolean read fSaveInterpreterHistory
      write fSaveInterpreterHistory;
  end;
{$METHODINFO OFF}

  TEditorSearchOptions = class(TPersistent)
  private
    fSearchBackwards: boolean;
    fSearchCaseSensitive: boolean;
    fSearchFromCaret: boolean;
    fSearchSelectionOnly: boolean;
    fSearchTextAtCaret: boolean;
    fSearchWholeWords: boolean;
    fUseRegExp: boolean;
    fIncrementalSearch: boolean;

    fSearchText: WideString;
    fSearchTextHistory: WideString;
    fReplaceText: WideString;
    fReplaceTextHistory: WideString;

    fTempSearchFromCaret: boolean;
    fInitBlockBegin : TBufferCoord;
    fInitBlockEnd : TBufferCoord;
    fInitCaretXY : TBufferCoord;
    fLastReplaceAction: TSynReplaceAction;
    fTempSelectionOnly : boolean;
    fNoReplaceCount : integer;
    fWrappedSearch : boolean;
    fCanWrapSearch : boolean;
    fBackwardSearch : boolean;
    fInterpreterIsSearchTarget : Boolean;
  public
    procedure Assign(Source: TPersistent); override;
    procedure InitSearch;
    procedure NewSearch(SynEdit : TSynEdit; ABackwards : Boolean);
    property SearchBackwards: boolean read fSearchBackwards write fSearchBackwards;
    property SearchText: WideString read fSearchText write fSearchText;
    property ReplaceText: WideString read fReplaceText write fReplaceText;
    property TempSearchFromCaret: boolean read fTempSearchFromCaret write fTempSearchFromCaret;
    property TempSelectionOnly: boolean read fTempSelectionOnly write fTempSelectionOnly;
    property NoReplaceCount: integer read fNoReplaceCount write fNoReplaceCount;
    property LastReplaceAction: TSynReplaceAction read fLastReplaceAction write fLastReplaceAction;
    property CanWrapSearch: boolean read fCanWrapSearch write fCanWrapSearch;
    property WrappedSearch: boolean read fWrappedSearch write fWrappedSearch;
    property BackwardSearch: boolean read fBackwardSearch write fBackwardSearch;
    property InitBlockBegin : TBufferCoord read fInitBlockBegin write fInitBlockBegin;
    property InitBlockEnd : TBufferCoord read fInitBlockEnd write fInitBlockEnd;
    property InitCaretXY : TBufferCoord read fInitCaretXY write fInitCaretXY;
    property InterpreterIsSearchTarget : Boolean read fInterpreterIsSearchTarget write fInterpreterIsSearchTarget;
  published
    property SearchTextHistory: WideString read fSearchTextHistory write fSearchTextHistory;
    property ReplaceTextHistory: WideString read fReplaceTextHistory write fReplaceTextHistory;
    property SearchSelectionOnly: boolean read fSearchSelectionOnly write fSearchSelectionOnly;
    property SearchCaseSensitive: boolean read fSearchCaseSensitive write fSearchCaseSensitive;
    property SearchFromCaret: boolean read fSearchFromCaret write fSearchFromCaret;
    property SearchTextAtCaret: boolean read fSearchTextAtCaret write fSearchTextAtCaret;
    property SearchWholeWords: boolean read fSearchWholeWords write fSearchWholeWords;
    property UseRegExp: boolean read fUseRegExp write fUseRegExp;
    property IncrementalSearch: boolean read fIncrementalSearch write fIncrementalSearch;
  end;

  TCommandsDataModule = class(TDataModule)
    SynPythonSyn: TSynPythonSyn;
    SynEditPrint: TSynEditPrint;
    PrintDialog: TPrintDialog;
    PrinterSetupDialog: TPrinterSetupDialog;
    CodeImages: TImageList;
    ParameterCompletion: TSynCompletionProposal;
    ModifierCompletion: TSynCompletionProposal;
    CodeTemplatesCompletion: TSynAutoComplete;
    imlShellIcon: TImageList;
    SynEditSearch: TSynEditSearch;
    SynEditRegexSearch: TSynEditRegexSearch;
    ProgramVersionCheck: TJvProgramVersionCheck;
    ProgramVersionHTTPLocation: TJvProgramVersionHTTPLocation;
    SynIniSyn: TSynIniSyn;
    JvMultiStringHolder: TJvMultiStringHolder;
    dlgFileOpen: TTntOpenDialogLX;
    dlgFileSave: TTntSaveDialogLX;
    SynWebHtmlSyn: TSynWebHtmlSyn;
    SynWebXmlSyn: TSynWebXmlSyn;
    SynWebCssSyn: TSynWebCssSyn;
    SynCppSyn: TSynCppSyn;
    SynWebEngine: TSynWebEngine;
    actlMain: TTntActionList;
    actFileCloseAllOther: TTntAction;
    actHelpWebGroupSupport: TTntAction;
    actHelpWebProjectHome: TTntAction;
    actSearchGoToDebugLine: TTntAction;
    actEditWordWrap: TTntAction;
    actSearchHighlight: TTntAction;
    actSearchReplaceNow: TTntAction;
    actExportHighlighters: TTntAction;
    actImportHighlighters: TTntAction;
    actExportShortCuts: TTntAction;
    actImportShortcuts: TTntAction;
    actFileReload: TTntAction;
    actEditUTF16BE: TTntAction;
    actEditUTF16LE: TTntAction;
    actEditUTF8NoBOM: TTntAction;
    actEditUTF8: TTntAction;
    actFileTemplates: TTntAction;
    actEditToggleComment: TTntAction;
    actInterpreterEditorOptions: TTntAction;
    actUnitTestWizard: TTntAction;
    actCheckForUpdates: TTntAction;
    actHelpEditorShortcuts: TTntAction;
    actEditAnsi: TTntAction;
    actEditLBMac: TTntAction;
    actEditLBUnix: TTntAction;
    actEditLBDos: TTntAction;
    actFindNextReference: TTntAction;
    actFindPreviousReference: TTntAction;
    actEditShowSpecialChars: TTntAction;
    actEditLineNumbers: TTntAction;
    actFindFunction: TTntAction;
    actHelpExternalTools: TTntAction;
    actConfigureTools: TTntAction;
    actCodeTemplates: TTntAction;
    actIDEShortcuts: TTntAction;
    actCustomizeParameters: TTntAction;
    actInsertTemplate: TTntAction;
    actHelpParameters: TTntAction;
    actReplaceParameters: TTntAction;
    actModifierCompletion: TTntAction;
    actParameterCompletion: TTntAction;
    actFindInFiles: TTntAction;
    actSearchGoToSyntaxError: TTntAction;
    actSearchGoToLine: TTntAction;
    actAbout: TTntAction;
    actPythonManuals: TTntHelpContents;
    actHelpContents: TTntHelpContents;
    actPythonPath: TTntAction;
    actEditUntabify: TTntAction;
    actEditTabify: TTntAction;
    actSearchMatchingBrace: TTntAction;
    actEditUncomment: TTntAction;
    actEditCommentOut: TTntAction;
    actEditDedent: TTntAction;
    actEditIndent: TTntAction;
    actIDEOptions: TTntAction;
    actEditorOptions: TTntAction;
    actPageSetup: TTntAction;
    actPrintPreview: TTntAction;
    actPrinterSetup: TTntAction;
    actFilePrint: TTntAction;
    actFileSaveAll: TTntAction;
    actSearchReplace: TTntAction;
    actSearchFindPrev: TTntAction;
    actSearchFindNext: TTntAction;
    actSearchFind: TTntAction;
    actEditSelectAll: TTntEditSelectAll;
    actEditRedo: TTntAction;
    actEditUndo: TTntEditUndo;
    actEditDelete: TTntEditDelete;
    actEditPaste: TTntEditPaste;
    actEditCopy: TTntEditCopy;
    actEditCut: TTntEditCut;
    actFileClose: TTntAction;
    actFileSaveAs: TTntAction;
    actFileSave: TTntAction;
    Images: TImageList;
    function ProgramVersionHTTPLocationLoadFileFromRemote(
      AProgramVersionLocation: TJvProgramVersionHTTPLocation; const ARemotePath,
      ARemoteFileName, ALocalPath, ALocalFileName: string): string;
    procedure actCheckForUpdatesExecute(Sender: TObject);
    procedure actUnitTestWizardExecute(Sender: TObject);
    procedure actIDEShortcutsExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actFilePrintExecute(Sender: TObject);
    procedure actFileCloseExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actEditDeleteExecute(Sender: TObject);
    procedure actEditSelectAllExecute(Sender: TObject);
    procedure actEditRedoExecute(Sender: TObject);
    procedure actEditUndoExecute(Sender: TObject);
    procedure actSearchFindExecute(Sender: TObject);
    procedure actSearchFindNextExecute(Sender: TObject);
    procedure actSearchFindPrevExecute(Sender: TObject);
    procedure actSearchReplaceExecute(Sender: TObject);
    procedure actFileSaveAllExecute(Sender: TObject);
    procedure actPrinterSetupExecute(Sender: TObject);
    procedure actPageSetupExecute(Sender: TObject);
    procedure actPrintPreviewExecute(Sender: TObject);
    procedure actEditorOptionsExecute(Sender: TObject);
    procedure actEditIndentExecute(Sender: TObject);
    procedure actEditDedentExecute(Sender: TObject);
    procedure actEditCommentOutExecute(Sender: TObject);
    procedure actEditUncommentExecute(Sender: TObject);
    procedure actSearchMatchingBraceExecute(Sender: TObject);
    procedure actEditTabifyExecute(Sender: TObject);
    procedure actEditUntabifyExecute(Sender: TObject);
    procedure actIDEOptionsExecute(Sender: TObject);
    procedure actPythonPathExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actPythonManualsExecute(Sender: TObject);
    procedure UpdateMainActions;
    procedure actSearchGoToLineExecute(Sender: TObject);
    procedure actFindInFilesExecute(Sender: TObject);
    procedure actHelpContentsExecute(Sender: TObject);
    procedure ParameterCompletionCodeCompletion(Sender: TObject;
      var Value: WideString; Shift: TShiftState; Index: Integer;
      EndToken: WideChar);
    procedure ModifierCompletionCodeCompletion(Sender: TObject;
      var Value: WideString; Shift: TShiftState; Index: Integer;
      EndToken: WideChar);
    procedure actParameterCompletionExecute(Sender: TObject);
    procedure actModifierCompletionExecute(Sender: TObject);
    procedure actReplaceParametersExecute(Sender: TObject);
    procedure actHelpParametersExecute(Sender: TObject);
    procedure actInsertTemplateExecute(Sender: TObject);
    procedure actCustomizeParametersExecute(Sender: TObject);
    procedure actCodeTemplatesExecute(Sender: TObject);
    procedure actConfigureToolsExecute(Sender: TObject);
    procedure actHelpExternalToolsExecute(Sender: TObject);
    procedure actFindFunctionExecute(Sender: TObject);
    procedure actEditLineNumbersExecute(Sender: TObject);
    procedure actEditShowSpecialCharsExecute(Sender: TObject);
    procedure actFindNextReferenceExecute(Sender: TObject);
    procedure actEditLBExecute(Sender: TObject);
    procedure actHelpEditorShortcutsExecute(Sender: TObject);
    procedure actInterpreterEditorOptionsExecute(Sender: TObject);
    procedure actEditToggleCommentExecute(Sender: TObject);
    procedure actFileTemplatesExecute(Sender: TObject);
    procedure actEditFileEncodingExecute(Sender: TObject);
    procedure actFileReloadExecute(Sender: TObject);
    procedure actExportShortCutsExecute(Sender: TObject);
    procedure actImportShortcutsExecute(Sender: TObject);
    procedure actExportHighlightersExecute(Sender: TObject);
    procedure actImportHighlightersExecute(Sender: TObject);
    procedure actSearchReplaceNowExecute(Sender: TObject);
    procedure actSearchGoToSyntaxErrorExecute(Sender: TObject);
    procedure actSearchHighlightExecute(Sender: TObject);
    procedure actEditWordWrapExecute(Sender: TObject);
    procedure actSearchGoToDebugLineExecute(Sender: TObject);
    procedure actHelpWebProjectHomeExecute(Sender: TObject);
    procedure actHelpWebGroupSupportExecute(Sender: TObject);
    procedure actFileCloseAllOtherExecute(Sender: TObject);
  private
    fHighlighters: TStrings;
    fUntitledNumbers: TBits;
    fConfirmReplaceDialogRect: TRect;
  public
    SynYAMLSyn: TSynYAMLSyn;
    BlockOpenerRE : TRegExpr;
    BlockCloserRE : TRegExpr;
    CommentLineRE : TRegExpr;
    NumberOfOriginalImages : integer;
    NonExecutableLineRE : TRegExpr;
    EditorOptions : TSynEditorOptionsContainer;
    InterpreterEditorOptions : TSynEditorOptionsContainer;
    PyIDEOptions : TPythonIDEOptions;
    UserDataDir : WideString;
    SkinFilesDir : WideString;
    function IsBlockOpener(S : string) : Boolean;
    function IsBlockCloser(S : string) : Boolean;
    function IsExecutableLine(Line : string) : Boolean;
    function GetHighlighterForFile(AFileName: WideString): TSynCustomHighlighter;
    procedure SynEditOptionsDialogGetHighlighterCount(Sender: TObject;
                var Count: Integer);
    procedure SynEditOptionsDialogGetHighlighter(Sender: TObject;
                Index: Integer; var SynHighlighter: TSynCustomHighlighter);
    procedure SynEditOptionsDialogSetHighlighter(Sender: TObject;
                Index: Integer; SynHighlighter: TSynCustomHighlighter);
    procedure SynInterpreterOptionsDialogGetHighlighterCount(Sender: TObject;
                var Count: Integer);
    procedure SynInterpreterOptionsDialogGetHighlighter(Sender: TObject;
                Index: Integer; var SynHighlighter: TSynCustomHighlighter);
    procedure SynInterpreterOptionsDialogSetHighlighter(Sender: TObject;
                Index: Integer; SynHighlighter: TSynCustomHighlighter);
    function GetSaveFileName(var ANewName: string;
      AHighlighter: TSynCustomHighlighter; DefaultExtension : string): boolean;
    function GetUntitledNumber: integer;
    procedure ReleaseUntitledNumber(ANumber: integer);
    procedure PaintMatchingBrackets(Canvas : TCanvas; SynEdit : TSynEdit;
      TransientType: TTransientType);
    function ShowPythonKeywordHelp(KeyWord : string) : Boolean;
    procedure PrepareParameterCompletion;
    procedure PrepareModifierCompletion;
    procedure VirtualStringTreeAdvancedHeaderDraw(Sender: TVTHeader;
      var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
    procedure VirtualStringTreeDrawQueryElements(
      Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
      var Elements: THeaderPaintElements);
    procedure VirtualStringTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VirtualStringTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure GetEditorUserCommand(AUserCommand: Integer; var ADescription: String);
    procedure GetEditorAllUserCommands(ACommands: TStrings);
    function DoSearchReplaceText(SynEdit : TSynEdit;
      AReplace, ABackwards : Boolean ; IsIncremental : Boolean = False) : integer;
    procedure ShowSearchReplaceDialog(SynEdit : TSynEdit; AReplace: boolean);
    procedure SynEditReplaceText(Sender: TObject; const ASearch,
      AReplace: WideString; Line, Column: Integer; var Action: TSynReplaceAction);
    procedure IncrementalSearch;
    procedure ApplyEditorOptions;
    procedure ProcessShellNotify(Sender: TCustomVirtualExplorerTree; ShellEvent: TVirtualShellEvent);
    function FileIsPythonSource(FileName : WideString): Boolean;
    property Highlighters : TStrings read fHighlighters;
    function FindSearchTarget : ISearchCommands;
  end;

Const
  ecRecallCommandPrev : word = ecUserFirst + 100;
  ecRecallCommandNext : word = ecUserFirst + 101;
  ecRecallCommandEsc : word = ecUserFirst + 102;
  ecCodeCompletion : word = ecUserFirst + 103;
  ecParamCompletion : word = ecUserFirst + 104;

var
  CommandsDataModule: TCommandsDataModule = nil;
  EditorSearchOptions : TEditorSearchOptions;

implementation

{$R *.DFM}

uses
  dlgSynPageSetup, uHighlighterProcs,
  dlgOptionsEditor, frmPythonII, dlgDirectoryList, 
  dlgAboutPyScripter, frmPyIDEMain, JclFileUtils, Variants,
  frmEditor, frmFindResults, cParameters, dlgCustomParams,
  uParams, dlgCodeTemplates, dlgConfigureTools, cTools,
  frmFunctionList, StringResources, uCommonFunctions,
  {uMMMXP_MainService, }JvJCLUtils, Menus, SynEditStrConst,
  dlgConfirmReplace, dlgCustomShortcuts,// jclStrings,
  dlgUnitTestWizard, WinInet, Registry, ShlObj, ShellAPI,
  dlgFileTemplates, JclSysUtils, dlgPickList, JvAppIniStorage,
  JvAppStorage, JvDSADialogs, uSearchHighlighter,
  TntSysUtils, MPShellUtilities, gnugettext, SpTBXSkins, SpTBXMDIMRU;

{ TPythonIDEOptions }

procedure TPythonIDEOptions.Assign(Source: TPersistent);
begin
  if Source is TPythonIDEOptions then
    with TPythonIDEOptions(Source) do begin
      Self.fTimeOut := TimeOut;
      Self.fUndoAfterSave := UndoAfterSave;
      Self.fSaveFilesBeforeRun := SaveFilesBeforeRun;
      Self.fSaveEnvironmentBeforeRun := SaveEnvironmentBeforeRun;
      Self.fRestoreOpenFiles := fRestoreOpenFiles;
      Self.fCreateBackUpFiles := CreateBackUpFiles;
      Self.fExporerInitiallyExpanded := ExporerInitiallyExpanded;
      Self.fSearchTextAtCaret := SearchTextAtCaret;
      Self.fPythonFileFilter := PythonFileFilter;
      Self.fHTMLFileFilter := HTMLFileFilter;
      Self.fXMLFileFilter := XMLFileFilter;
      Self.fCSSFileFilter := CSSFileFilter;
      Self.fCPPFileFilter := CPPFileFilter;
      Self.fYAMLFileFilter := YAMLFileFilter;
      Self.fFileExplorerFilter := FileExplorerFilter;
      Self.fDateLastCheckedForUpdates := DateLastCheckedForUpdates;
      Self.fAutoCheckForUpdates := AutoCheckForUpdates;
      Self.fDaysBetweenChecks := DaysBetweenChecks;
      Self.fMaskFPUExceptions := MaskFPUExceptions;
      Self.fSpecialPackages := SpecialPackages;
      Self.fUTF8inInterpreter := UTF8inInterpreter;
      Self.fShowCodeHints := ShowCodeHints;
      Self.fShowDebuggerHints := ShowDebuggerHints;
      Self.fAutoCompleteBrackets := AutoCompleteBrackets;
      Self.fUseCommandLine := UseCommandLine;
      Self.fCommandLine := CommandLine;
      Self.fMarkExecutableLines := MarkExecutableLines;
      Self.fCheckSyntaxAsYouType := CheckSyntaxAsYouType;
      Self.fFileExplorerContextMenu := FileExplorerContextMenu;
      Self.fNewFileLineBreaks := NewFileLineBreaks;
      Self.fNewFileEncoding := NewFileEncoding;
      Self.fDetectUTF8Encoding := DetectUTF8Encoding;
      Self.fEditorsTabPosition := EditorsTabPosition;
      Self.fPythonEngineType := PythonEngineType;
      Self.fPrettyPrintOutput := PrettyPrintOutput;
      Self.fSmartNextPrevPage := SmartNextPrevPage;
      Self.fAutoReloadChangedFiles := AutoReloadChangedFiles;
      Self.fClearOutputBeforeRun := ClearOutputBeforeRun;
      Self.fAutoHideFindToolbar := AutoHideFindToolbar;
      Self.fEditorCodeCompletion := EditorCodeCompletion;
      Self.fInterpreterCodeCompletion := InterpreterCodeCompletion;
      Self.fCodeCompletionListSize := CodeCompletionListSize;
      Self.fShowTabCloseButton := ShowTabCloseButton;
      Self.fPostMortemOnException := PostMortemOnException;
      Self.fDockAnimationInterval := DockAnimationInterval;
      Self.fDockAnimationMoveWidth := DockAnimationMoveWidth;
      Self.fInterpreterHistorySize := InterpreterHistorySize;
      Self.fSaveInterpreterHistory := SaveInterpreterHistory;
    end
  else
    inherited;
end;

procedure TPythonIDEOptions.Changed;
begin
  PyIDEMainForm.PyIDEOptionsChanged;
end;

constructor TPythonIDEOptions.Create;
begin
  fTimeOut := 0; // 5000;
  fUndoAfterSave := True;
  fSaveFilesBeforeRun := True;
  fSaveEnvironmentBeforeRun := False;
  fCreateBackupFiles := False;
  fExporerInitiallyExpanded := False;
  fPythonFileFilter := 'Python Files (*.py;*.pyw)|*.py;*.pyw';
  fHTMLFileFilter := SYNS_FilterHTML;
  fXMLFileFilter := SYNS_FilterXML;
  fCSSFileFilter := SYNS_FilterCSS;
  fCPPFileFilter := SYNS_FilterCPP;
  fYAMLFileFilter := SYNS_FilterYAML;
  fFileExplorerFilter := '*.py;*.pyw';
  fSearchTextAtCaret := True;
  fRestoreOpenFiles := True;
  fDateLastCheckedForUpdates := MinDateTime;
  fAutoCheckForUpdates := True;
  fDaysBetweenChecks := 7;
  fMaskFPUExceptions := True;
  fSpecialPackages := 'os, wx, scipy';
  fUTF8inInterpreter := True;
  fShowCodeHints := True;
  fShowDebuggerHints := True;
  fAutoCompleteBrackets := True;
  fMarkExecutableLines := True;
  fCheckSyntaxAsYouType := True;
  fFileExplorerContextMenu := True;
  fNewFileLineBreaks := sffDos;
  fNewFileEncoding := sf_Ansi;
  fDetectUTF8Encoding := True;
  fEditorsTabPosition := ttpBottom;
  fPythonEngineType := peInternal;
  fPrettyPrintOutput := True;
  fSmartNextPrevPage := True;
  fAutoReloadChangedFiles := True;
  fClearOutputBeforeRun := False;
  fAutoHideFindToolbar := False;
  fEditorCodeCompletion := True;
  fInterpreterCodeCompletion := True;
  fCodeCompletionListSize := 8;
  fShowTabCloseButton := True;
  fPostMortemOnException := False;
  fDockAnimationInterval := 20;
  fDockAnimationMoveWidth := 20;
  fInterpreterHistorySize := 50;
  fSaveInterpreterHistory := True;
end;

function TPythonIDEOptions.GetPythonFileExtensions: string;
begin
  Result := FileMaskFromFileFilter(PythonFileFilter);
end;

{ TEditorSearchOptions }

procedure TEditorSearchOptions.Assign(Source: TPersistent);
begin
  if Source is TEditorSearchOptions then
    with TEditorSearchOptions(Source) do begin
      Self.fSearchBackwards := SearchBackwards;
      Self.fSearchCaseSensitive := SearchCaseSensitive;
      Self.fSearchFromCaret := SearchFromCaret;
      Self.fTempSearchFromCaret := TempSearchFromCaret;
      Self.fSearchSelectionOnly := SearchSelectionOnly;
      Self.fSearchTextAtCaret := SearchTextAtCaret;
      Self.fSearchWholeWords := SearchWholeWords;
      Self.fUseRegExp := UseRegExp;
      Self.fIncrementalSearch := IncrementalSearch;

      Self.fSearchText := SearchText;
      Self.fSearchTextHistory := SearchTextHistory;
      Self.fReplaceText := ReplaceText;
      Self.fReplaceTextHistory := ReplaceTextHistory;
    end
  else
    inherited;
end;

procedure TEditorSearchOptions.InitSearch;
begin
  TempSearchFromCaret := SearchFromCaret;
  LastReplaceAction := raReplace;
  InitBlockBegin := BufferCoord(0, 0);
end;

procedure TEditorSearchOptions.NewSearch(SynEdit : TSynEdit; ABackwards : Boolean);

  function BC_GT(BC1, BC2 : TBufferCoord): Boolean;
  begin
    Result := (BC1.Line > BC2.Line) or (BC1.Line = BC2.Line) and (BC1.Char > BC2.Char);
  end;
Var
  TextLeft : WideString;
  SearchOptions : TSynSearchOptions;
begin
  InitSearch;
  BackwardSearch := ABackwards;
  WrappedSearch := False;
  TempSelectionOnly := SearchSelectionOnly and SynEdit.SelAvail;
  if TempSelectionOnly then begin
    InitBlockBegin := SynEdit.BlockBegin;
    InitBlockEnd := SynEdit.BlockEnd;
  end else begin
    InitBlockBegin := BufferCoord(1, 1);
    InitBlockEnd  := BufferCoord(Length(SynEdit.Lines[SynEdit.Lines.Count - 1]) + 1,
                                 SynEdit.Lines.Count);
  end;

  if TempSelectionOnly then begin
    if ABackwards then
      InitCaretXY := InitBlockEnd
    else
      InitCaretXY := InitBlockBegin;
  end else begin
    if ABackwards then
      SynEdit.CaretXY := SynEdit.BlockBegin
    else
      SynEdit.CaretXY := SynEdit.BlockEnd;
    InitCaretXY := SynEdit.CaretXY;
  end;

  CanWrapSearch := (ABackwards and BC_GT(InitBlockEnd, InitCaretXY) or
             (not ABackwards and BC_GT(InitCaretXY, InitBlockBegin)));
  if CanWrapSearch then begin
    if ABackwards then
      TextLeft := GetBlockText(SynEdit.Lines, InitCaretXY, InitBlockEnd)
    else
      TextLeft := GetBlockText(SynEdit.Lines, InitBlockBegin, InitCaretXY);
    SearchOptions := [];
    if EditorSearchOptions.SearchCaseSensitive then
      Include(SearchOptions, ssoMatchCase);
    if EditorSearchOptions.SearchWholeWords then
      Include(SearchOptions, ssoWholeWord);
    SynEdit.SearchEngine.Options := SearchOptions;
    try
      SynEdit.SearchEngine.Pattern := SearchText;
      CanWrapSearch := SynEdit.SearchEngine.FindAll(TextLeft) > 0;
    except
      on E: ERegExpr do begin
        CanWrapSearch := False;
      end;
    end;  
  end;
end;

{ TCommandsDataModule }

type
  TCrackSynCustomHighlighter = class(TSynCustomHighlighter)
  end;

procedure TCommandsDataModule.DataModuleCreate(Sender: TObject);

var
  i: Integer;
  Highlighter : TSynCustomHighlighter;
  SHFileInfo: TSHFileInfo;
  Index : integer;
begin
  // User Data directory for storing the ini file etc.
  UserDataDir := WideIncludeTrailingPathDelimiter(UserDocumentsFolder.NameForParsing) + 'PyScripter\';
  if not WideForceDirectories(UserDataDir) then
    WideMessageDlg(WideFormat(SAccessAppDataDir, [UserDataDir]), mtWarning, [mbOK], 0);
  // Skins directory
  SkinFilesDir := UserDataDir + 'Skins';
  if not WideDirectoryExists(SkinFilesDir) then
    try
      WideCreateDir(SkinFilesDir);
    except
    end;

  // Setup Highlighters
  SynYAMLSyn := TSynYAMLSyn.Create(Self);
  fHighlighters := TStringList.Create;
  TStringList(fHighlighters).CaseSensitive := False;
  GetHighlighters(Self, fHighlighters, False);
  TStringList(fHighlighters).Sort;

  //  Place Python first
  Index := fHighlighters.IndexOf(SynPythonSyn.FriendlyLanguageName);
  if Index >= 0 then fHighlighters.Delete(Index);
  fHighlighters.InsertObject(0, SynPythonSyn.FriendlyLanguageName, SynPythonSyn);

  // this is to save the internal state of highlighter attributes
  // Work around for the reported bug according to which some
  // highlighter attributes were not saved
  for i := 0 to Highlighters.Count - 1 do begin
    Highlighter := Highlighters.Objects[i] as TSynCustomHighlighter;
    with TCrackSynCustomHighlighter(Highlighter) do
        SetAttributesOnChange(DefHighlightChange);
  end;

  // DefaultOptions
  PyIDEOptions := TPythonIDEOptions.Create;

  // SynWeb Highlighters do not provide default filters
  SynWebHTMLSyn.DefaultFilter := PyIDEOptions.HTMLFileFilter;
  SynWebXMLSyn.DefaultFilter := PyIDEOptions.XMLFileFilter;
  SynWebCssSyn.DefaultFilter := PyIDEOptions.CSSFileFilter;

  MaskFPUExceptions(PyIDEOptions.fMaskFPUExceptions);
  dlgFileOpen.Filter := PyIDEOptions.PythonFileFilter;

  BlockOpenerRE := TRegExpr.Create;
  BlockOpenerRE.Expression := ':\s*(#.*)?$';
  BlockCloserRE := TRegExpr.Create;
  BlockCloserRE.Expression := '\s*(return|break|continue|raise|pass)\b';
  NonExecutableLineRE := TRegExpr.Create;
  NonExecutableLineRE.Expression := '(^\s*(class|def)\b)|(^\s*#)|(^\s*$)';
  CommentLineRE := TRegExpr.Create;
  CommentLineRE.Expression := '^##';
  CommentLineRE.ModifierM := True;

  EditorOptions := TSynEditorOptionsContainer.Create(Self);
  with EditorOptions do begin
    Font.Height := -13;
    if Win32PlatformIsVista then
      Font.Name := 'Consolas'
    else
      Font.Name := 'Courier New';
    Gutter.Font.Height := -11;
    Gutter.Font.Name := 'Courier New';
    Gutter.Gradient := True;
    Gutter.LeftOffset := 25;
    Gutter.RightOffset := 1;
    Gutter.Width := 27;
    Gutter.DigitCount := 3;
    Gutter.Autosize := True;

    Options := [eoAutoSizeMaxScrollWidth, eoDragDropEditing, eoEnhanceHomeKey,
                eoEnhanceEndKey, eoGroupUndo, eoHideShowScrollbars, eoKeepCaretX,
                eoShowScrollHint, eoSmartTabDelete, eoTabsToSpaces, eoTabIndent,
                eoTrimTrailingSpaces, eoAutoIndent, eoRightMouseMovesCursor];
    TabWidth := 4;
    WantTabs := True;
    TabWidth := 4;

    //SelectedColor.Background := SelectionBackgroundColor;
    Keystrokes.Delete(Keystrokes.FindCommand(ecMatchBracket));
    // Register the CodeCompletion Command
    with Keystrokes.Add do begin
      ShortCut := Menus.ShortCut(VK_SPACE, [ssCtrl]);
      Command := ecCodeCompletion;
    end;
    // Register the ParamCompletion Command
    with Keystrokes.Add do begin
      ShortCut := Menus.ShortCut(VK_SPACE, [ssCtrl, ssShift]);
      Command := ecParamCompletion;
    end;
  end;
  InterpreterEditorOptions := TSynEditorOptionsContainer.Create(Self);
  InterpreterEditorOptions.Assign(EditorOptions);
  InterpreterEditorOptions.Options := InterpreterEditorOptions.Options -
    [eoTrimTrailingSpaces];
  InterpreterEditorOptions.WordWrap := True;
  InterpreterEditorOptions.Gutter.Visible := False;
  InterpreterEditorOptions.RightEdge := 0;


  with SynEditPrint.Header do begin
    Add('$TITLE$', nil, taCenter, 2);
  end;
  with SynEditPrint.Footer do begin
    Add('$PAGENUM$/$PAGECOUNT$', nil, taCenter, 1);
  end;

  // Parameter Completion
  PrepareParameterCompletion;
  PrepareModifierCompletion;

  // Setup the ShellIcon imagelist
  imlShellIcon.Handle := SHGetFileInfo('', 0, SHFileInfo, SizeOf(SHFileInfo),
    SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  NumberOfOriginalImages := Images.Count;

  // Help file
  //StoHelpViewer.HtmlExt := '.html';

  //Program Version Check
  ProgramVersionCheck.ThreadDialog.DialogOptions.ShowModal := False;
  ProgramVersionCheck.ThreadDialog.DialogOptions.Caption := 'Downloading...';
  ProgramVersionCheck.ThreadDialog.DialogOptions.ResName := 'WebCopyAvi';
  ProgramVersionCheck.LocalDirectory := ExtractFilePath(Application.ExeName)+ 'Updates';

  // Translate
  TranslateComponent(Self);
end;

procedure TCommandsDataModule.DataModuleDestroy(Sender: TObject);
begin
  fHighlighters.Free;
  fUntitledNumbers.Free;
  CommandsDataModule := nil;
  BlockOpenerRE.Free;
  BlockCloserRE.Free;
  NonExecutableLineRE.Free;
  CommentLineRE.Free;
  PyIDEOptions.Free;
  imlShellIcon.Handle := 0;
end;

// implementation

function TCommandsDataModule.GetHighlighterForFile(
  AFileName: WideString): TSynCustomHighlighter;
begin
  if AFileName <> '' then
    Result := GetHighlighterFromFileExt(fHighlighters, WideExtractFileExt(AFileName))
  else
    Result := nil;
end;

procedure TCommandsDataModule.SynEditOptionsDialogGetHighlighterCount(Sender: TObject;
  var Count: Integer);
begin
   Count := fHighlighters.Count;
end;

procedure TCommandsDataModule.SynEditOptionsDialogGetHighlighter(Sender: TObject;
  Index: Integer; var SynHighlighter: TSynCustomHighlighter);
begin
   if (Index >= 0) and (Index < fHighlighters.Count) then
      SynHighlighter := fHighlighters.Objects[Index] as TSynCustomHighlighter
   else
     SynHighlighter := nil;
end;

procedure TCommandsDataModule.SynEditOptionsDialogSetHighlighter(Sender: TObject;
  Index: Integer; SynHighlighter: TSynCustomHighlighter);
begin
   if (Index >= 0) and (Index < fHighlighters.Count) then
     (fHighlighters.Objects[Index] as TSynCustomHighlighter).Assign(SynHighlighter);
end;

procedure TCommandsDataModule.SynInterpreterOptionsDialogGetHighlighter(
  Sender: TObject; Index: Integer; var SynHighlighter: TSynCustomHighlighter);
begin
  if Index = 1 then
    SynHighlighter := PythonIIForm.SynEdit.Highlighter
  else
    SynHighlighter := nil;
end;

procedure TCommandsDataModule.SynInterpreterOptionsDialogGetHighlighterCount(
  Sender: TObject; var Count: Integer);
begin
  Count := 1;
end;

procedure TCommandsDataModule.SynInterpreterOptionsDialogSetHighlighter(
  Sender: TObject; Index: Integer; SynHighlighter: TSynCustomHighlighter);
begin
  PythonIIForm.SynEdit.Highlighter.Assign(SynHighlighter);
end;

function TCommandsDataModule.GetSaveFileName(var ANewName: string;
  AHighlighter: TSynCustomHighlighter; DefaultExtension : string): boolean;
begin
  with dlgFileSave do begin
    if ANewName <> '' then begin
      InitialDir := ExtractFileDir(ANewName);
      FileName := ExtractFileName(ANewName);
      Title := WideFormat(_(SSaveAs), [FileName]);
    end else begin
      InitialDir := '';
      FileName := '';
      Title := _(SSaveFileAs);
    end;
    if AHighlighter <> nil then
      Filter := AHighlighter.DefaultFilter
    else
      Filter := _(SFilterAllFiles);

    DefaultExt := DefaultExtension;
    //  Make the current file extension the default extension
    if DefaultExt = '' then
      DefaultExt := ExtractFileExt(ANewName);

    if Execute then begin
      ANewName := FileName;
      Result := TRUE;
    end else
      Result := FALSE;
  end;
end;

function TCommandsDataModule.GetUntitledNumber: integer;
begin
  if fUntitledNumbers = nil then
    fUntitledNumbers := TBits.Create;
  Result := fUntitledNumbers.OpenBit;
  if Result = fUntitledNumbers.Size then
    fUntitledNumbers.Size := fUntitledNumbers.Size + 32;
  fUntitledNumbers[Result] := TRUE;
  Inc(Result);
end;

procedure TCommandsDataModule.ReleaseUntitledNumber(ANumber: integer);
begin
  Dec(ANumber);
  if (fUntitledNumbers <> nil) and (ANumber >= 0)
    and (ANumber < fUntitledNumbers.Size)
  then
    fUntitledNumbers[ANumber] := FALSE;
end;

procedure TCommandsDataModule.actFileSaveExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecSave;
end;

procedure TCommandsDataModule.actFileSaveAsExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecSaveAs;
end;

procedure TCommandsDataModule.actFileSaveAllExecute(Sender: TObject);
var
  i : integer;
  FileCommands : IFileCommands;
begin
  for i := 0 to GI_EditorFactory.Count -1 do begin
    FileCommands := GI_EditorFactory[i] as IFileCommands;
    if Assigned(FileCommands) and FileCommands.CanSave then
      FileCommands.ExecSave;
  end;
end;

procedure TCommandsDataModule.actFilePrintExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecPrint;
end;

procedure TCommandsDataModule.actFileReloadExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecReload;
end;

procedure TCommandsDataModule.actPrintPreviewExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecPrintPreview;
end;

procedure TCommandsDataModule.actPrinterSetupExecute(Sender: TObject);
begin
  PrinterSetupDialog.Execute;
end;

procedure TCommandsDataModule.actPageSetupExecute(Sender: TObject);
begin
  with TPageSetupDlg.Create(Self) do begin
    SetValues(SynEditPrint);
    if ShowModal = mrOk then
      GetValues(SynEditPrint);
    Release;
  end;
end;

procedure TCommandsDataModule.actFileCloseAllOtherExecute(Sender: TObject);
Var
  Editor : IEditor;
  i : integer;
begin
  Editor := PyIDEMainForm.GetActiveEditor;
  if not Assigned(Editor) then Exit;

  for i := GI_EditorFactory.Count -1 downto 0 do
    if GI_EditorFactory.Editor[i] <> Editor then
      GI_EditorFactory.Editor[i].Close;

  Editor.Activate;
end;

procedure TCommandsDataModule.actFileCloseExecute(Sender: TObject);
begin
  if GI_FileCmds <> nil then
    GI_FileCmds.ExecClose;
end;

procedure TCommandsDataModule.actEditCutExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecCut;
end;

procedure TCommandsDataModule.actEditCopyExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecCopy;
end;

procedure TCommandsDataModule.actEditPasteExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecPaste;
end;

procedure TCommandsDataModule.actEditDeleteExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecDelete;
end;

procedure TCommandsDataModule.actEditSelectAllExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecSelectAll;
end;

procedure TCommandsDataModule.actEditRedoExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecRedo;
end;

procedure TCommandsDataModule.actEditUndoExecute(Sender: TObject);
begin
  if GI_EditCmds <> nil then
    GI_EditCmds.ExecUndo;
end;

procedure TCommandsDataModule.actSearchFindExecute(Sender: TObject);
Var
  SearchCommands : ISearchCommands;
begin
  SearchCommands := FindSearchTarget;
  if SearchCommands <> nil then
    SearchCommands.ExecFind
end;

procedure TCommandsDataModule.actSearchFindNextExecute(Sender: TObject);
Var
  SearchCommands : ISearchCommands;
begin
  SearchCommands := FindSearchTarget;
  if SearchCommands <> nil then
    SearchCommands.ExecFindNext
end;

procedure TCommandsDataModule.actSearchFindPrevExecute(Sender: TObject);
Var
  SearchCommands : ISearchCommands;
begin
  SearchCommands := FindSearchTarget;
  if SearchCommands <> nil then
    SearchCommands.ExecFindPrev
end;

procedure TCommandsDataModule.actSearchReplaceExecute(Sender: TObject);
Var
  SearchCommands : ISearchCommands;
begin
  SearchCommands := FindSearchTarget;
  if SearchCommands <> nil then
    SearchCommands.ExecReplace
end;

procedure TCommandsDataModule.IncrementalSearch;
Var
  SearchCmds : ISearchCommands;
begin
  SearchCmds := FindSearchTarget;
  if Assigned(SearchCmds) then with SearchCmds do begin
    SearchTarget.SetCaretAndSelection(SearchTarget.BlockBegin, SearchTarget.BlockBegin, SearchTarget.BlockBegin);
    EditorSearchOptions.InitSearch;
    DoSearchReplaceText(SearchTarget, False, False, True);
  end;
end;

procedure TCommandsDataModule.actSearchReplaceNowExecute(Sender: TObject);
Var
  SearchCmds : ISearchCommands;
begin
  SearchCmds := FindSearchTarget;
  if Assigned(SearchCmds) then with SearchCmds do begin
    EditorSearchOptions.InitSearch;
    DoSearchReplaceText(SearchTarget, True, EditorSearchOptions.SearchBackwards);
  end;
end;

procedure TCommandsDataModule.actSearchGoToDebugLineExecute(Sender: TObject);
begin
  with PyControl.CurrentPos do
    if (Line >= 1) and (PyControl.ActiveDebugger <> nil) and not PyControl.IsRunning then
      PyIDEMainForm.SetCurrentPos(Editor , Line)
end;

procedure TCommandsDataModule.actSearchGoToLineExecute(Sender: TObject);
Var
  Line : WideString;
  LineNo : integer;
begin
  if Assigned(GI_ActiveEditor) then
    if WideInputQuery(_(SGoToLineNumber), _(SEnterLineNumber), Line) then begin
      try
        LineNo := StrToInt(Line);
        GI_ActiveEditor.ActiveSynEdit.CaretXY := BufferCoord(1, LineNo);
      except
        on E: EConvertError do begin
          WideMessageDlg(WideFormat(_(SNotAValidNumber), [Line]), mtError,
            [mbAbort], 0);
        end;
      end;
    end;
end;

procedure TCommandsDataModule.actSearchGoToSyntaxErrorExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    TEditorForm(GI_ActiveEditor.Form).GoToSyntaxError;
end;

procedure TCommandsDataModule.actSearchHighlightExecute(Sender: TObject);
Var
  SearchEngine : TSynEditSearchCustom;
  SearchOptions : TSynSearchOptions;
  Editor : IEditor;
begin
  Editor := PyIDEMainForm.GetActiveEditor;
  if Assigned(Editor) and (EditorSearchOptions.SearchText <> '') then begin
    if actSearchHighlight.Checked then begin
      SearchOptions := [];
      if EditorSearchOptions.SearchCaseSensitive then
        Include(SearchOptions, ssoMatchCase);
      if EditorSearchOptions.SearchWholeWords then
        Include(SearchOptions, ssoWholeWord);

      if EditorSearchOptions.UseRegExp then
        SearchEngine := SynEditRegexSearch
      else
        SearchEngine := SynEditSearch;

      FindSearchTerm(EditorSearchOptions.SearchText, Editor.SynEdit,
        TEditorForm(Editor.Form).FoundSearchItems, SearchEngine, SearchOptions);
      InvalidateHighlightedTerms(Editor.SynEdit2, TEditorForm(Editor.Form).FoundSearchItems);
    end else
      ClearAllHighlightedTerms;
  end;
end;

procedure TCommandsDataModule.actFindInFilesExecute(Sender: TObject);
begin
  if Assigned(FindResultsWindow) then
    FindResultsWindow.Execute(False)
end;

procedure TCommandsDataModule.actUnitTestWizardExecute(Sender: TObject);
Var
  Tests : string;
  Editor : IEditor;
begin
  if Assigned(GI_ActiveEditor) and GI_ActiveEditor.HasPythonFile then begin
    Tests := TUnitTestWizard.GenerateTests(GI_ActiveEditor.GetFileNameOrTitle,
      GI_ActiveEditor.SynEdit.Text);
    if Tests <> '' then begin
      Editor := PyIDEMainForm.DoOpenFile('', 'Python');
      if Assigned(Editor) then 
        Editor.SynEdit.SelText := Tests;
    end;
  end;
end;

procedure TCommandsDataModule.ApplyEditorOptions;
// Assign Editor Options to all open editors
var
  i : integer;
begin
  for i := 0 to GI_EditorFactory.Count - 1 do begin
    GI_EditorFactory.Editor[i].SynEdit.Assign(EditorOptions);
    GI_EditorFactory.Editor[i].SynEdit2.Assign(EditorOptions);
  end;

//  InterpreterEditorOptions.Assign(EditorOptions);
//  InterpreterEditorOptions.Options := InterpreterEditorOptions.Options -
//    [eoTrimTrailingSpaces, eoTabsToSpaces];
//  PythonIIForm.SynEdit.Assign(InterpreterEditorOptions);
  InterpreterEditorOptions.Keystrokes.Assign(EditorOptions.Keystrokes);
  PythonIIForm.SynEdit.Keystrokes.Assign(EditorOptions.Keystrokes);
  PythonIIForm.RegisterHistoryCommands;
  PythonIIForm.SynEdit.Highlighter.Assign(CommandsDataModule.SynPythonSyn);
end;

procedure TCommandsDataModule.actEditorOptionsExecute(Sender: TObject);
var
  TempEditorOptions : TSynEditorOptionsContainer;
  TempFileName : string;
begin
  TempEditorOptions := TSynEditorOptionsContainer.Create(Self);
  // SynWeb attribute changes are taking immediate effect in Web Engine
  // So Cancel does not work.  As a workaround we save the syntax attributes
  // and restore them if the dialog is cancelled.
  TempFileName := FileGetTempName('PyScripter');
  SynWebHtmlSyn.SaveToFile(TempFileName);
  try
    with TSynEditOptionsDialog.Create(Self) do begin
      if Assigned(GI_ActiveEditor) then begin
        TempEditorOptions.Assign(GI_ActiveEditor.ActiveSynEdit);
        Form.cbApplyToAll.Checked := True;
        Form.cbApplyToAll.Enabled := True;
      end else begin
        TempEditorOptions.Assign(EditorOptions);
        Form.cbApplyToAll.Checked := True;
        Form.cbApplyToAll.Enabled := False;
      end;
      OnGetHighlighterCount := SynEditOptionsDialogGetHighlighterCount;
      OnGetHighlighter := SynEditOptionsDialogGetHighlighter;
      OnSetHighlighter := SynEditOptionsDialogSetHighlighter;
      VisiblePages := [soDisplay, soOptions, soKeystrokes, soColor];
      GetUserCommand := GetEditorUserCommand;
      GetAllUserCommands := GetEditorAllUserCommands;
      UseExtendedStrings := True;
      if Execute(TempEditorOptions) then begin
        UpdateHighlighters;
        if Form.cbApplyToAll.Checked then begin
          EditorOptions.Assign(TempEditorOptions);
          ApplyEditorOptions;
          PyIDEMainForm.StoreApplicationData;
        end else if Assigned(GI_ActiveEditor) then
          GI_ActiveEditor.ActiveSynEdit.Assign(TempEditorOptions);
      end else
        //  If canceled restore original settings
        SynWebHtmlSyn.LoadFromFile(TempFileName);
      Free;
    end;
  finally
    TempEditorOptions.Free;
    DeleteFile(TempFileName);
  end;
end;

procedure TCommandsDataModule.actInterpreterEditorOptionsExecute(
  Sender: TObject);
var
  TempEditorOptions : TSynEditorOptionsContainer;
begin
  TempEditorOptions := TSynEditorOptionsContainer.Create(Self);
  try
    with TSynEditOptionsDialog.Create(Self) do begin
      TempEditorOptions.Assign(PythonIIForm.SynEdit);
      Form.cbApplyToAll.Checked := False;
      Form.cbApplyToAll.Enabled := False;
      Form.Caption := 'Interpreter Editor Options';
      OnGetHighlighterCount := SynEditOptionsDialogGetHighlighterCount;
      OnGetHighlighter := SynInterpreterOptionsDialogGetHighlighter;
      OnSetHighlighter := SynInterpreterOptionsDialogSetHighlighter;
      VisiblePages := [soDisplay, soOptions, soColor];
      if Execute(TempEditorOptions) then begin
        UpdateHighlighters;
        InterpreterEditorOptions.Assign(TempEditorOptions);
        InterpreterEditorOptions.Options := (InterpreterEditorOptions.Options -
          [eoTrimTrailingSpaces]) + [eoTabsToSpaces];
        PythonIIForm.SynEdit.Assign(InterpreterEditorOptions);
      end;
      Free;
    end;
  finally
    TempEditorOptions.Free;
  end;
end;

procedure TCommandsDataModule.actEditIndentExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecBlockIndent, ' ', nil);
end;

procedure TCommandsDataModule.actEditDedentExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.ExecuteCommand(ecBlockUnIndent, ' ', nil);
end;

procedure TCommandsDataModule.actEditToggleCommentExecute(Sender: TObject);
var
  i, EndLine : integer;
  BlockIsCommented : Boolean;
begin
  if Assigned(GI_ActiveEditor) then with GI_ActiveEditor.ActiveSynEdit do begin
    if (BlockBegin.Line <> BlockEnd.Line) and (BlockEnd.Char = 1) then
      EndLine := BlockEnd.Line - 1
    else
      EndLine := BlockEnd.Line;

    BlockIsCommented := True;
    for i  := BlockBegin.Line to EndLine do
      if Copy(Lines[i-1], 1, 2) <> '##' then begin
        BlockIsCommented := False;
        Break;
      end;

    if BlockIsCommented then
      actEditUncommentExecute(Sender)
    else
      actEditCommentOutExecute(Sender);
  end;
end;

procedure TCommandsDataModule.actEditFileEncodingExecute(Sender: TObject);
begin
  if (Sender is TAction) and Assigned(GI_ActiveEditor) then begin
    GI_ActiveEditor.FileEncoding := TFileSaveFormat(TAction(Sender).Tag);
    GI_ActiveEditor.SynEdit.Modified := True;
  end;
end;

procedure TCommandsDataModule.actEditCommentOutExecute(Sender: TObject);
var
  S: WideString;
  Offset: integer;
  OldBlockBegin, OldBlockEnd : TBufferCoord;
begin
  if Assigned(GI_ActiveEditor) then with GI_ActiveEditor.ActiveSynEdit do begin
    OldBlockBegin := BlockBegin;
    OldBlockEnd := BlockEnd;
    if SelAvail then begin // has selection
      OldBlockBegin := BufferCoord(1, OldBlockBegin.Line);
      BlockBegin := OldBlockBegin;
      BlockEnd := OldBlockEnd;
      BeginUpdate;
      S:='##'+SelText;
      Offset:=0;
      if S[Length(S)]=#10 then begin // if the selection ends with a newline, eliminate it
        if S[Length(S)-1]=#13 then // do we ignore 1 or 2 chars?
          Offset:=2
        else
          Offset:=1;
        S:=Copy(S, 1, Length(S)-Offset);
      end;
      S := UnicodeStringReplace(S, #10, #10'##', [rfReplaceAll]);
      if Offset=1 then
        S:=S+#10
      else if Offset=2 then
        S:=S + WideLineBreak;
      SelText := S;
      EndUpdate;
      BlockBegin := OldBlockBegin;
      if Offset = 0 then
        Inc(OldBlockEnd.Char, 2);
      BlockEnd := BufferCoord(OldBlockEnd.Char, OldBlockEnd.Line);
    end
    else  begin // no selection; easy stuff ;)
      // Do with selection to be able to undo
      //LineText:='##'+LineText;
      CaretXY := BufferCoord(1, CaretY);
      SelText := '##';
      CaretXY := BufferCoord(OldBlockEnd.Char + 2, OldBlockEnd.Line);
    end;
    UpdateCaret;
  end;
end;

procedure TCommandsDataModule.actEditUncommentExecute(Sender: TObject);
Var
  OldBlockBegin, OldBlockEnd : TBufferCoord;
begin
  if Assigned(GI_ActiveEditor) then with GI_ActiveEditor.ActiveSynEdit do begin
    OldBlockBegin := BlockBegin;
    OldBlockEnd := BlockEnd;
    if SelAvail then
    begin
      OldBlockBegin := BufferCoord(1, OldBlockBegin.Line);
      BlockBegin := OldBlockBegin;
      BlockEnd := OldBlockEnd;
      SelText := CommentLineRE.Replace(SelText, '', False);
      BlockBegin := OldBlockBegin;
      BlockEnd := BufferCoord(OldBlockEnd.Char - 2, OldBlockEnd.Line);
    end else begin
      BlockBegin := BufferCoord(1, CaretY);
      BlockEnd := BufferCoord(Length(LineText)+1, CaretY);
      SelText := CommentLineRE.Replace(SelText, '', False);
      CaretXY := BufferCoord(OldBlockEnd.Char - 2, OldBlockEnd.Line);
    end;
    UpdateCaret;
  end;
end;

procedure TCommandsDataModule.actEditTabifyExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then with GI_ActiveEditor.ActiveSynEdit do begin
    if SelAvail then
    begin
       SelText :=  UnicodeStringReplace(SelText,
         StringOfChar(' ',GI_ActiveEditor.SynEdit.TabWidth), #9, [rfReplaceAll]);
       UpdateCaret;
    end;
  end;
end;

procedure TCommandsDataModule.actEditUntabifyExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then with GI_ActiveEditor.ActiveSynEdit do begin
    if SelAvail then
    begin
       SelText :=  UnicodeStringReplace(SelText, #9,
         StringOfChar(' ',GI_ActiveEditor.SynEdit.TabWidth), [rfReplaceAll]);
       UpdateCaret;
    end;
  end;
end;

procedure TCommandsDataModule.actExportHighlightersExecute(Sender: TObject);
Var
  i : integer;
  AppStorage : TJvAppIniFileStorage;
begin
  with dlgFileSave do begin
    Title := _(SExportHighlighters);
    Filter := SynIniSyn.DefaultFilter;
    DefaultExt := 'ini';
    if Execute then begin
      AppStorage := TJvAppIniFileStorage.Create(nil);
      try
        AppStorage.FlushOnDestroy := True;
        AppStorage.Location := flCustom;
        AppStorage.FileName := FileName;
        AppStorage.WriteString('PyScripter\Version', ApplicationVersion);
        AppStorage.DeleteSubTree('Highlighters');
        for i := 0 to Highlighters.Count - 1 do
          AppStorage.WritePersistent('Highlighters\'+Highlighters[i],
            TPersistent(Highlighters.Objects[i]));
          AppStorage.WritePersistent('Highlighters\Intepreter',
            PythonIIForm.SynEdit.Highlighter);
      finally
        AppStorage.Free;
      end;
    end;
  end;
end;

procedure TCommandsDataModule.actExportShortCutsExecute(Sender: TObject);
Var
  AppStorage : TJvAppIniFileStorage;
  ActionProxyCollection: TActionProxyCollection;
begin
  with dlgFileSave do begin
    Title := _(SExportShortcuts);
    Filter := SynIniSyn.DefaultFilter;
    DefaultExt := 'ini';
    if Execute then begin
      AppStorage := TJvAppIniFileStorage.Create(nil);
      try
        AppStorage.FlushOnDestroy := True;
        AppStorage.Location := flCustom;
        AppStorage.FileName := FileName;
        AppStorage.StorageOptions.StoreDefaultValues := False;
        AppStorage.WriteString('PyScripter\Version', ApplicationVersion);
        AppStorage.DeleteSubTree('IDE Shortcuts');
        ActionProxyCollection := TActionProxyCollection.Create(PyIDEMainForm.ActionListArray);
        try
          AppStorage.WriteCollection('IDE Shortcuts', ActionProxyCollection, 'Action');
        finally
          ActionProxyCollection.Free;
        end;
        AppStorage.DeleteSubTree('Editor Shortcuts');
        AppStorage.WriteCollection('Editor Shortcuts', EditorOptions.Keystrokes);
      finally
        AppStorage.Free;
      end;
    end;
  end;
end;

procedure TCommandsDataModule.actImportHighlightersExecute(Sender: TObject);
Var
  i : integer;
  AppStorage : TJvAppIniFileStorage;
begin
  with dlgFileOpen do begin
    Title := _(SImportHighlighters);
    Filter := SynIniSyn.DefaultFilter;
    FileName := '';
    if Execute then begin
      AppStorage := TJvAppIniFileStorage.Create(nil);
      try
        AppStorage.FlushOnDestroy := False;
        AppStorage.Location := flCustom;
        AppStorage.FileName := FileName;
        for i := 0 to Highlighters.Count - 1 do
          AppStorage.ReadPersistent('Highlighters\'+Highlighters[i],
            TPersistent(Highlighters.Objects[i]));
        PythonIIForm.SynEdit.Highlighter.Assign(CommandsDataModule.SynPythonSyn);
        if AppStorage.IniFile.SectionExists('Highlighters\Intepreter') then
          AppStorage.ReadPersistent('Highlighters\Intepreter',
            PythonIIForm.SynEdit.Highlighter);
      finally
        AppStorage.Free;
      end;
    end;
  end;
end;

procedure TCommandsDataModule.actImportShortcutsExecute(Sender: TObject);
Var
  i : integer;
  AppStorage : TJvAppIniFileStorage;
  ActionProxyCollection: TActionProxyCollection;
begin
  with dlgFileOpen do begin
    Title := _(SImportShortcuts);
    Filter := SynIniSyn.DefaultFilter;
    FileName := '';
    if Execute then begin
      AppStorage := TJvAppIniFileStorage.Create(nil);
      try
        AppStorage.Location := flCustom;
        AppStorage.FileName := FileName;

        if AppStorage.PathExists('IDE Shortcuts') then begin
          ActionProxyCollection := TActionProxyCollection.Create(PyIDEMainForm.ActionListArray);
          try
            AppStorage.ReadCollection('IDE Shortcuts', ActionProxyCollection, True, 'Action');
            ActionProxyCollection.ApplyShortCuts(PyIDEMainForm.ActionListArray);
          finally
            ActionProxyCollection.Free;
          end;
        end;
        if AppStorage.PathExists('Editor Shortcuts') then begin
          AppStorage.ReadCollection('Editor Shortcuts', EditorOptions.Keystrokes, True);
          for i := 0 to GI_EditorFactory.Count - 1 do
            GI_EditorFactory.Editor[i].SynEdit.Keystrokes.Assign(EditorOptions.Keystrokes);
          InterpreterEditorOptions.Keystrokes.Assign(EditorOptions.Keystrokes);
          PythonIIForm.SynEdit.Keystrokes.Assign(EditorOptions.Keystrokes);
          PythonIIForm.RegisterHistoryCommands;
        end;
      finally
        AppStorage.Free;
      end;
    end;
  end;
end;

procedure TCommandsDataModule.actEditLBExecute(Sender: TObject);
begin
  if (Sender is TAction) and Assigned(GI_ActiveEditor) then begin
    (GI_ActiveEditor.SynEdit.Lines as TSynEditStringList).FileFormat :=
      TSynEditFileFormat(TAction(Sender).Tag);
    GI_ActiveEditor.SynEdit.Modified := True;
  end;
end;

procedure TCommandsDataModule.actSearchMatchingBraceExecute(
  Sender: TObject);
Var
  P : TBufferCoord;
begin
  if Assigned(GI_ActiveEditor) then with GI_ActiveEditor.ActiveSynEdit do begin
    P := GetMatchingBracket;
    if (P.Char > 0) and (P.Line > 0) then
      CaretXY := P;
  end;
end;

function TCommandsDataModule.IsBlockCloser(S: string): Boolean;
begin
  Result := BlockCloserRE.Exec(S);
end;

function TCommandsDataModule.IsBlockOpener(S: string): Boolean;
begin
  Result := BlockOpenerRE.Exec(S);
end;

function TCommandsDataModule.IsExecutableLine(Line: string): Boolean;
begin
  Result := not ((Line = '') or NonExecutableLineRE.Exec(Line));
end;

procedure TCommandsDataModule.PaintMatchingBrackets(Canvas : TCanvas;
  SynEdit : TSynEdit; TransientType: TTransientType);
{-----------------------------------------------------------------------------
  Based on code from devcpp (dev-cpp.sf.net)
-----------------------------------------------------------------------------}
const
  Brackets: array[0..5] of char = ('(', ')', '[', ']', '{', '}');

  function CharToPixels(P: TBufferCoord): TPoint;
  begin
    Result:= SynEdit.RowColumnToPixels(SynEdit.BufferToDisplayPos(P));
  end;

  procedure GetMatchingBrackets(P : TBufferCoord; out PM : TBufferCoord;
    out IsBracket, HasMatchingBracket : Boolean; out BracketCh, MatchCh : Char;
    out Attri: TSynHighlighterAttributes);
  var
    S: WideString;
    I: Integer;
  begin
    IsBracket := False;
    HasMatchingBracket := False;
    PM := BufferCoord(0,0);
    SynEdit.GetHighlighterAttriAtRowCol(P, S, Attri);
    if Assigned(Attri) and (SynEdit.Highlighter.SymbolAttribute = Attri) and
        (SynEdit.CaretX<=length(SynEdit.LineText) + 1) then begin
      for i := Low(Brackets) to High(Brackets) do
        if S = Brackets[i] then begin
          BracketCh := Brackets[i];
          IsBracket := True;
          PM := SynEdit.GetMatchingBracketEx(P);
          if (PM.Char > 0) then begin
            HasMatchingBracket := True;
            MatchCh := Brackets[i xor 1];
          end;
          break;
        end;
    end;
  end;

var
  P, PM: TBufferCoord;
  PD, PMD : TDisplayCoord;
  Pix: TPoint;
  R : TRect;
  BracketCh, MatchCh : Char;
  IsBracket, HasMatchingBracket : Boolean;
  Attri: TSynHighlighterAttributes;
begin
  P := SynEdit.CaretXY;

  // First Look at the previous character like Site
  if P.Char > 1 then Dec(P.Char);
  GetMatchingBrackets(P, PM, IsBracket, HasMatchingBracket, BracketCh, MatchCh, Attri);

  //if it is not a bracket then look at the next character;
  if not IsBracket and (SynEdit.CaretX > 1) then begin
    Inc(P.Char);
    GetMatchingBrackets(P, PM, IsBracket, HasMatchingBracket, BracketCh, MatchCh, Attri);
  end;

  if IsBracket then begin
    PD := SynEdit.BufferToDisplayPos(P);
    Pix := SynEdit.RowColumnToPixels(PD);
    // Calculate here as a workaround to UniSynEdit quirk in which
    // BufferToDisplayPos resets the font
    if HasMatchingBracket then
      PMD := SynEdit.BufferToDisplayPos(PM);

    Canvas.Brush.Style := bsSolid;
    Canvas.Font.Assign(SynEdit.Font);
    Canvas.Font.Style := Attri.Style;

    if SynEdit.IsPointInSelection(P) then
      Canvas.Brush.Color := SynEdit.SelectedColor.Background
    else if (Synedit.ActiveLineColor <> clNone) and (SynEdit.CaretY = P.Line) then
      Canvas.Brush.Color := SynEdit.ActiveLineColor
    else if Attri.Background <> clNone then
      Canvas.Brush.Color := Attri.Background
    else if SynPythonSyn.SpaceAttri.Background <> clNone then
      Canvas.Brush.Color := SynPythonSyn.SpaceAttri.Background
    else
      Canvas.Brush.Color := Synedit.Color;

    if (TransientType = ttAfter) then begin
      if HasMatchingBracket then
        Canvas.Font.Color:= clBlue
      else
        Canvas.Font.Color:= clRed;
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    end
    else begin
      Canvas.Font.Style := Attri.Style;
      Canvas.Font.Color:= Attri.Foreground;;
    end;

    if (PD.Column >= SynEdit.LeftChar) and
      (PD.Column < SynEdit.LeftChar + SynEdit.CharsInWindow) and
      (PD.Row > 0)and (PD.Row >= SynEdit.TopLine) and
      (PD.Row < SynEdit.TopLine + SynEdit.LinesInWindow) then
    begin
      R := Rect(Pix.X, Pix.Y, Pix.X + SynEdit.CharWidth, Pix.Y + SynEdit.LineHeight);
      Canvas.TextRect(R, Pix.X, Pix.Y, BracketCh);
    end;

    if HasMatchingBracket and (PMD.Column >= SynEdit.LeftChar) and
      (PMD.Column < SynEdit.LeftChar + SynEdit.CharsInWindow) and
      (PMD.Row > 0)and (PMD.Row >= SynEdit.TopLine) and
      (PMD.Row < SynEdit.TopLine + SynEdit.LinesInWindow) then
    begin
      if SynEdit.IsPointInSelection(PM) then
        Canvas.Brush.Color := SynEdit.SelectedColor.Background
      else if (Synedit.ActiveLineColor <> clNone) and (SynEdit.CaretY = PM.Line) then
        Canvas.Brush.Color := SynEdit.ActiveLineColor
      else if Attri.Background <> clNone then
        Canvas.Brush.Color := Attri.Background
      else if SynPythonSyn.SpaceAttri.Background <> clNone then
        Canvas.Brush.Color := SynPythonSyn.SpaceAttri.Background
      else
        Canvas.Brush.Color := Synedit.Color;
      Pix := SynEdit.RowColumnToPixels(PMD);

      R := Rect(Pix.X, Pix.Y, Pix.X + SynEdit.CharWidth, Pix.Y + SynEdit.LineHeight);
      Canvas.TextRect(R, Pix.X, Pix.Y, MatchCh);
    end;
  end;

  Canvas.Brush.Style := bsSolid;
end;

procedure TCommandsDataModule.ProcessShellNotify(Sender: TCustomVirtualExplorerTree;
  ShellEvent: TVirtualShellEvent);

  function AreFileTimesEqual(FT1, FT2 : TFileTime) : Boolean;
  begin
    Result := (FT1.dwLowDateTime = FT2.dwLowDateTime) and
              (FT1.dwHighDateTime = FT2.dwHighDateTime);
  end;

Var
  i : integer;
  ModifiedCount : integer;
  Editor : IEditor;
  ChangedFiles : TStringList;
  SafeGuard: ISafeGuard;
  NS: TNamespace;
  Dir : string;
  FTime : TFileTime;
begin
//  if not (ShellEvent.ShellNotifyEvent in [vsneUpdateDir, vsneUpdateItem]) then Exit;
  if not (ShellEvent.ShellNotifyEvent = vsneUpdateDir) then Exit;

  Dir := '';
  NS := TNamespace.Create(ShellEvent.PIDL1, nil);
  try
    NS.FreePIDLOnDestroy := False;
    Dir := NS.NameForParsing;
    if not NS.Folder then // UpdateItem notifications
      Dir := ExtractFileDir(Dir);
  finally
    NS.Free;
  end;

  if Dir = '' then Exit;

  ChangedFiles := TStringList.Create;
  Guard(ChangedFiles, SafeGuard);

  for i := 0 to GI_EditorFactory.Count -1 do begin
    Editor := GI_EditorFactory.Editor[i];
    if (Editor.FileName <> '') and (ExtractFileDir(Editor.FileName) = Dir) then begin
      if not FileTimeLastWriteRaw(Editor.FileName, FTime) then begin
        // File or directory has been moved or deleted
        if not AreFileTimesEqual(TEditorForm(Editor.Form).FileTime, ZeroFileTime) then begin
          // Mark as modified so that we try to save it
          Editor.SynEdit.Modified := True;
          // Set FileTime to zero to prevent further notifications
          TEditorForm(Editor.Form).FileTime := ZeroFileTime;
          WideMessageDlg(WideFormat(_(SFileRenamedOrDeleted), [Editor.FileName]) , mtWarning, [mbOK], 0);
        end;
      end else if not AreFileTimesEqual(TEditorForm(Editor.Form).FileTime, FTime) then begin
        ChangedFiles.AddObject(Editor.GetFileNameOrTitle, Editor.Form);
        // Prevent further notifications on this file
        TEditorForm(Editor.Form).FileTime := FTime;
      end;
    end;
  end;

  ModifiedCount := 0;
  for I := 0 to ChangedFiles.Count - 1 do begin
    Editor := TEditorForm(ChangedFiles.Objects[i]).GetEditor;
    if Editor.Modified then
      Inc(ModifiedCount);
    Editor.SynEdit.Modified := True;  //So that we are prompted to save changes
  end;

  if ChangedFiles.Count > 0 then
    if PyIDEOptions.AutoReloadChangedFiles and (ModifiedCount = 0) then begin
      for I := 0 to ChangedFiles.Count - 1 do begin
        Editor := TEditorForm(ChangedFiles.Objects[i]).GetEditor;
        (Editor as IFileCommands).ExecReload(True);
      end;
      MessageBeep(MB_ICONASTERISK);
      PyIDEMainForm.WriteStatusMsg(_(SChangedFilesReloaded));
    end
    else with TPickListDialog.Create(Application.MainForm) do begin
      Caption := _(SFileChangeNotification);
      lbMessage.Caption := _(SFileReloadWarning);
      CheckListBox.Items.Assign(ChangedFiles);
      SetScrollWidth;
      mnSelectAllClick(nil);
      if ShowModal = IdOK then 
        for i := CheckListBox.Count - 1 downto 0 do begin
          if CheckListBox.Checked[i] then begin
            Editor := TEditorForm(CheckListBox.Items.Objects[i]).GetEditor;
            (Editor as IFileCommands).ExecReload(True);
          end;
        end;
      Release;
    end;
end;           

procedure TCommandsDataModule.PrepareParameterCompletion;
var
  i : integer;
  ParamName, ParamValue : WideString;
begin
  with ParameterCompletion do begin
    ItemList.Clear;
    InsertList.Clear;
    for i := 0 to Parameters.Count - 1 do begin
      Parameters.Split(i, ParamName, ParamValue, False);
      ItemList.Add(Format('\color{clBlue}%s\color{clBlack}\column{}%s',
         [ParamName, StringReplace(ParamValue, '\', '\\', [rfReplaceAll])]));
      InsertList.Add(ParamName);
    end;
  end;
end; 

procedure TCommandsDataModule.PrepareModifierCompletion;
var
  i : integer;
  ModName, ModComment : string;
begin
  with ModifierCompletion do begin
    ItemList.Clear;
    InsertList.Clear;
    for i := 0 to Parameters.Modifiers.Count - 1 do begin
      ModName := Parameters.Modifiers.Names[i];
      ModComment := Parameters.Modifiers.Values[ModName];
      ItemList.Add(Format('\color{clBlue}%s\color{clBlack}\column{}%s', [ModName, ModComment]));
      InsertList.Add(ModName);
    end;
  end;
end;

procedure TCommandsDataModule.actIDEOptionsExecute(Sender: TObject);
//TODO Localize Display Names
Var
  Categories : array of TOptionCategory;
  Reg : TRegistry;
  IsRegistered : Boolean;
  Key : string;
begin
  SetLength(Categories, 7);
  with Categories[0] do begin
    DisplayName := 'IDE';
    SetLength(Options, 8);
    Options[0].PropertyName := 'AutoCheckForUpdates';
    Options[0].DisplayName := 'Check for updates automatically';
    Options[1].PropertyName := 'DaysBetweenChecks';
    Options[1].DisplayName := 'Days between update checks';
    Options[2].PropertyName := 'MaskFPUExceptions';
    Options[2].DisplayName := 'Mask FPU Exceptions';
    Options[3].PropertyName := 'EditorsTabPosition';
    Options[3].DisplayName := 'Editor tab position';
    Options[4].PropertyName := 'SmartNextPrevPage';
    Options[4].DisplayName := 'Smart Next Previous Page';
    Options[5].PropertyName := 'ShowTabCloseButton';
    Options[5].DisplayName := 'Show tab close button';
    Options[6].PropertyName := 'DockAnimationInterval';
    Options[6].DisplayName := 'Dock animation interval (ms)';
    Options[7].PropertyName := 'DockAnimationMoveWidth';
    Options[7].DisplayName := 'Dock animation move width (pixels)';
  end;
  with Categories[1] do begin
    DisplayName := 'Python Interpreter';
    SetLength(Options, 10);
    Options[0].PropertyName := 'SaveFilesBeforeRun';
    Options[0].DisplayName := 'Save files before run';
    Options[1].PropertyName := 'SaveEnvironmentBeforeRun';
    Options[1].DisplayName := 'Save environment before run';
    Options[2].PropertyName := 'TimeOut';
    Options[2].DisplayName := 'Timeout for running scripts in ms';
    Options[3].PropertyName := 'UTF8inInterpreter';
    Options[3].DisplayName := 'UTF8 in interactive interpreter';
    Options[4].PropertyName := 'PythonEngineType';
    Options[4].DisplayName := 'Python engine type';
    Options[5].PropertyName := 'PrettyPrintOutput';
    Options[5].DisplayName := 'Pretty print output';
    Options[6].PropertyName := 'ClearOutputBeforeRun';
    Options[6].DisplayName := 'Clear output before run';
    Options[7].PropertyName := 'PostMortemOnException';
    Options[7].DisplayName := 'Post-mortem on exception';
    Options[8].PropertyName := 'InterpreterHistorySize';
    Options[8].DisplayName := 'Interpreter history size';
    Options[9].PropertyName := 'SaveInterpreterHistory';
    Options[9].DisplayName := 'Save interpreter history';
  end;
  with Categories[2] do begin
    DisplayName := 'Code Explorer';
    SetLength(Options, 1);
    Options[0].PropertyName := 'ExporerInitiallyExpanded';
    Options[0].DisplayName := 'Initially expanded';
  end;
  with Categories[3] do begin
    DisplayName := 'File Filters';
    SetLength(Options, 7);
    Options[0].PropertyName := 'PythonFileFilter';
    Options[0].DisplayName := 'Open dialog Python filter';
    Options[1].PropertyName := 'HTMLFileFilter';
    Options[1].DisplayName := 'Open dialog HTML filter';
    Options[2].PropertyName := 'XMLFileFilter';
    Options[2].DisplayName := 'Open dialog XML filter';
    Options[3].PropertyName := 'CSSFileFilter';
    Options[3].DisplayName := 'Open dialog CSS filter';
    Options[4].PropertyName := 'CPPFileFilter';
    Options[4].DisplayName := 'Open dialog CPP filter';
    Options[5].PropertyName := 'YAMLFileFilter';
    Options[5].DisplayName := 'Open dialog YAML filter';
    Options[6].PropertyName := 'FileExplorerFilter';
    Options[6].DisplayName := 'File explorer filter';
  end;
  with Categories[4] do begin
    DisplayName := 'Editor';
    SetLength(Options, 14);
    Options[0].PropertyName := 'RestoreOpenFiles';
    Options[0].DisplayName := 'Restore open files';
    Options[1].PropertyName := 'SearchTextAtCaret';
    Options[1].DisplayName := 'Search text at caret';
    Options[2].PropertyName := 'CreateBackupFiles';
    Options[2].DisplayName := 'Create backup files';
    Options[3].PropertyName := 'UndoAfterSave';
    Options[3].DisplayName := 'Undo after save';
    Options[4].PropertyName := 'ShowCodeHints';
    Options[4].DisplayName := 'Show code hints';
    Options[5].PropertyName := 'ShowDebuggerHints';
    Options[5].DisplayName := 'Show debugger hints';
    Options[6].PropertyName := 'AutoCompleteBrackets';
    Options[6].DisplayName := 'Auto-complete brackets';
    Options[7].PropertyName := 'MarkExecutableLines';
    Options[7].DisplayName := 'Show executable line marks';
    Options[8].PropertyName := 'CheckSyntaxAsYouType';
    Options[8].DisplayName := 'Check syntax as you type';
    Options[9].PropertyName := 'NewFileLineBreaks';
    Options[9].DisplayName := 'Default line break format for new files';
    Options[10].PropertyName := 'NewFileEncoding';
    Options[10].DisplayName := 'Default file encoding for new files';
    Options[11].PropertyName := 'DetectUTF8Encoding';
    Options[11].DisplayName := 'Detect UTF-8 encoding when opening files';
    Options[12].PropertyName := 'AutoReloadChangedFiles';
    Options[12].DisplayName := 'Auto-reload changed files';
    Options[13].PropertyName := 'AutoHideFindToolbar';
    Options[13].DisplayName := 'Auto-hide find toolbar';
  end;
  with Categories[5] do begin
    DisplayName := 'Code Completion';
    SetLength(Options, 4);
    Options[0].PropertyName := 'SpecialPackages';
    Options[0].DisplayName := 'Special packages';
    Options[1].PropertyName := 'CodeCompletionListSize';
    Options[1].DisplayName := 'Code completion list size';
    Options[2].PropertyName := 'EditorCodeCompletion';
    Options[2].DisplayName := 'Editor code completion';
    Options[3].PropertyName := 'InterpreterCodeCompletion';
    Options[3].DisplayName := 'Interpreter code completion';
  end;
  with Categories[6] do begin
    DisplayName := 'Shell Integration';
    SetLength(Options, 1);
    Options[0].PropertyName := 'FileExplorerContextMenu';
    Options[0].DisplayName := 'File Explorer context menu';
  end;

  // Shell Integration
  IsRegistered := False;
  Reg := TRegistry.Create(KEY_READ and not KEY_NOTIFY);
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Key := 'Python.File\shell\Edit with PyScripter';
    IsRegistered := Reg.KeyExists(Key);
  except
  end;
  FreeAndNil(Reg);

  PyIDEOptions.FileExplorerContextMenu := IsRegistered;

  PyIDEOptions.SearchTextAtCaret := EditorSearchOptions.SearchTextAtCaret;

  if InspectOptions(PyIDEOptions, Categories, _(SIDEOptions), 610) then begin
    PyIDEMainForm.PyIDEOptionsChanged;
    PyIDEMainForm.StoreApplicationData;
    if PyIDEOptions.FileExplorerContextMenu <> IsRegistered then begin
      Reg := TRegistry.Create;
      try
        if IsRegistered then begin
          Reg.DeleteKey(Key)
        end else begin
          Reg.OpenKey(Key, True);
          Reg.CloseKey;
          Reg.OpenKey(Key + '\command', True);
          Reg.WriteString('', '"'+ Application.ExeName+ '" "%1"') ;
          Reg.CloseKey;
        end;

        SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
      except
        WideMessageDlg(_(SRegistryAccessDenied), mtError, [mbOK], 0);
      end;
      FreeAndNil(Reg);
    end;
  end;
end;

procedure TCommandsDataModule.actIDEShortcutsExecute(Sender: TObject);
begin
  with TfrmCustomKeyboard.Create(Self) do begin
    if Execute(PyIDEMainForm.ActionListArray) then
      PyIDEMainForm.StoreApplicationData;
    Release;
  end;
end;

procedure TCommandsDataModule.actPythonPathExecute(Sender: TObject);
Var
  Paths : TUnicodeStringList;
begin
  Paths := TUnicodeStringList.Create;
  try
    PyControl.ActiveInterpreter.SysPathToStrings(Paths);
    if EditFolderList(Paths, 'Python Path', 870) then 
      PyControl.ActiveInterpreter.StringsToSysPath(Paths);
  finally
    Paths.Free;
  end;
end;

procedure TCommandsDataModule.actAboutExecute(Sender: TObject);
begin
  with TAboutBox.Create(Self) do begin
    ShowModal;
    Release;
  end;
end;

procedure TCommandsDataModule.actPythonManualsExecute(Sender: TObject);
Var
  OldHelpFile : string;
begin
  if PythonIIForm.PythonHelpFile <> '' then begin
    OldHelpFile := Application.HelpFile;
    Application.HelpFile := PythonIIForm.PythonHelpFile;
    PyIDEMainForm.MenuHelpRequested := True;
    try
      Application.HelpCommand(HELP_CONTENTS, 0);
    finally
      Application.HelpFile := OldHelpFile;
      PyIDEMainForm.MenuHelpRequested := False;
    end;
  end;
end;

function TCommandsDataModule.ShowPythonKeywordHelp(KeyWord : string): Boolean;
Var
  OldHelpFile : string;
begin
  Result := False;
  if PythonIIForm.PythonHelpFile <> '' then begin
    OldHelpFile := Application.HelpFile;
    Application.HelpFile := PythonIIForm.PythonHelpFile;
    PyIDEMainForm.PythonKeywordHelpRequested := True;
    try
      Result := Application.HelpKeyword(KeyWord);
    finally
      PyIDEMainForm.PythonKeywordHelpRequested := False;
      Application.HelpFile := OldHelpFile;
    end;
  end;
end;

procedure TCommandsDataModule.UpdateMainActions;
Var
  i : integer;
  SelAvail : Boolean;
  SaveAll : Boolean;
  Editor : IEditor;
  SearchCommands : ISearchCommands;
begin
  // Edit actions
//  actEditCut.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanCut;
//  actEditCopy.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanCopy;
//  actEditPaste.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanPaste;
//  actEditDelete.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanDelete;
//  actEditSelectAll.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanSelectAll;
//  actEditUndo.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanUndo;
  actEditRedo.Enabled := (GI_EditCmds <> nil) and GI_EditCmds.CanRedo;

  actEditLBDos.Enabled := Assigned(GI_ActiveEditor);
  actEditLBDos.Checked := Assigned(GI_ActiveEditor) and
    ((GI_ActiveEditor.SynEdit.Lines as TSynEditStringList).FileFormat = sffDos);
  actEditLBUnix.Enabled := Assigned(GI_ActiveEditor);
  actEditLBUnix.Checked := Assigned(GI_ActiveEditor) and
    ((GI_ActiveEditor.SynEdit.Lines as TSynEditStringList).FileFormat = sffUnix);
  actEditLBMac.Enabled := Assigned(GI_ActiveEditor);
  actEditLBMac.Checked := Assigned(GI_ActiveEditor) and
    ((GI_ActiveEditor.SynEdit.Lines as TSynEditStringList).FileFormat = sffMac);
  actEditAnsi.Enabled := Assigned(GI_ActiveEditor);
  actEditAnsi.Checked := Assigned(GI_ActiveEditor) and
    (GI_ActiveEditor.FileEncoding = sf_Ansi);
  actEditUTF8.Enabled := Assigned(GI_ActiveEditor);
  actEditUTF8.Checked := Assigned(GI_ActiveEditor) and
    (GI_ActiveEditor.FileEncoding = sf_UTF8);
  actEditUTF8NoBOM.Enabled := Assigned(GI_ActiveEditor);
  actEditUTF8NoBOM.Checked := Assigned(GI_ActiveEditor) and
    (GI_ActiveEditor.FileEncoding = sf_UTF8_NoBOM);
  actEditUTF16LE.Enabled := Assigned(GI_ActiveEditor);
  actEditUTF16LE.Checked := Assigned(GI_ActiveEditor) and
    (GI_ActiveEditor.FileEncoding = sf_UTF16LE);
  actEditUTF16BE.Enabled := Assigned(GI_ActiveEditor);
  actEditUTF16BE.Checked := Assigned(GI_ActiveEditor) and
    (GI_ActiveEditor.FileEncoding = sf_UTF16BE);

  SelAvail := Assigned(GI_EditCmds) and GI_EditCmds.CanCopy;
  // Source Code Actions
  actEditIndent.Enabled := SelAvail;
  actEditDedent.Enabled := SelAvail;
  actEditTabify.Enabled := SelAvail;
  actEditUnTabify.Enabled := SelAvail;
  actEditToggleComment.Enabled := Assigned(GI_ActiveEditor);
  actEditCommentOut.Enabled := Assigned(GI_ActiveEditor);
  actEditUncomment.Enabled := Assigned(GI_ActiveEditor);
  actEditLineNumbers.Enabled := Assigned(GI_ActiveEditor);
  actEditWordWrap.Enabled := Assigned(GI_ActiveEditor);
  actEditShowSpecialChars.Enabled := Assigned(GI_ActiveEditor);
  if Assigned(GI_ActiveEditor) then begin
    actEditLineNumbers.Checked := GI_ActiveEditor.ActiveSynEdit.Gutter.ShowLineNumbers;
    actEditWordWrap.Checked := GI_ActiveEditor.ActiveSynEdit.WordWrap;
    actEditShowSpecialChars.Checked := eoShowSpecialChars in GI_ActiveEditor.ActiveSynEdit.Options;
  end else begin
    actEditLineNumbers.Checked := False;
    actEditWordWrap.Checked := False;
    actEditShowSpecialChars.Checked := False;
  end;

  // File Actions
  actFileReload.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanReload;
  actFileClose.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanClose;
  actFilePrint.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanPrint;
  actPrintPreview.Enabled := actFilePrint.Enabled;
  actFileSave.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanSave;
  actFileSaveAs.Enabled := (GI_FileCmds <> nil) and GI_FileCmds.CanSaveAs;
  // Lesson to remember do not change the Enabled state of an Action from false to true
  // within an Update or OnIdle handler. The result is 100% CPU utilisation.
  // Therefore I introduced here a new boolean variable.
  // actFileSaveAll.Enabled := False;
  SaveAll := False;
  for i := 0 to GI_EditorFactory.Count -1 do
    if (GI_EditorFactory[i] as IFileCommands).CanSave then begin
      SaveAll := True;
      break;
    end;
  actFileSaveAll.Enabled := SaveAll;

  // Search Actions
  SearchCommands := FindSearchTarget;
  actSearchFind.Enabled := (SearchCommands <> nil) and SearchCommands.CanFind;
  actSearchFindNext.Enabled := (SearchCommands <> nil) and SearchCommands.CanFindNext;
  actSearchFindPrev.Enabled := actSearchFindNext.Enabled;
  actSearchReplace.Enabled := (SearchCommands <> nil) and SearchCommands.CanReplace;
  actSearchReplaceNow.Enabled := actSearchFindNext.Enabled and SearchCommands.CanReplace;
  Editor := PyIDEMainForm.GetActiveEditor;
  SearchCommands := nil;
  if Assigned(Editor) then
    SearchCommands := Editor as ISearchCommands;
  actSearchHighlight.Enabled := Assigned(SearchCommands) and SearchCommands.CanFindNext;
  actSearchHighlight.Checked := actSearchHighlight.Enabled and
    (TEditorForm(Editor.Form).FoundSearchItems.Count > 0);

  actSearchMatchingBrace.Enabled := Assigned(GI_ActiveEditor);
  actSearchGoToLine.Enabled := Assigned(GI_ActiveEditor);
  actSearchGoToSyntaxError.Enabled := Assigned(GI_ActiveEditor) and
    TEditorForm(GI_ActiveEditor.Form).HasSyntaxError;
  actSearchGoToDebugLine.Enabled := (PyControl.CurrentPos.Line >= 1) and
    (PyControl.ActiveDebugger <> nil) and not PyControl.IsRunning;
  actFindInFiles.Enabled := not FindResultsWindow.DoingSearchOrReplace;

  if Assigned(GI_ActiveEditor) and GI_ActiveEditor.HasPythonFile then begin
    actFindFunction.Enabled := True;
    actUnitTestWizard.Enabled := True;
  end else begin
    actFindFunction.Enabled := False;
    actUnitTestWizard.Enabled := False;
  end;

  // Parameter and Code Template Actions
  if Assigned(Screen.ActiveControl) and (Screen.ActiveControl is TSynEdit) then begin
    actParameterCompletion.Enabled := True;
    actModifierCompletion.Enabled := True;
    actReplaceParameters.Enabled := True;
    actInsertTemplate.Enabled := True;
  end else begin
    actParameterCompletion.Enabled := False;
    actModifierCompletion.Enabled := False;
    actReplaceParameters.Enabled := False;
    actInsertTemplate.Enabled := False;
  end;
end;

procedure TCommandsDataModule.actHelpContentsExecute(Sender: TObject);
begin
  PyIDEMainForm.MenuHelpRequested := True;
  Application.HelpCommand(HELP_CONTENTS, 0);
  PyIDEMainForm.MenuHelpRequested := False;
end;

procedure TCommandsDataModule.ParameterCompletionCodeCompletion(
  Sender: TObject; var Value: WideString; Shift: TShiftState; Index: Integer;
  EndToken: WideChar);
begin
  if ssCtrl in Shift then
    Value := Parameters.Values[Value]
  else
    Value := Parameters.MakeParameter(Value);
end;

procedure TCommandsDataModule.ModifierCompletionCodeCompletion(
  Sender: TObject; var Value: WideString; Shift: TShiftState; Index: Integer;
  EndToken: WideChar);
var
  L: Integer;
begin
  if Assigned(ModifierCompletion.Editor) then
    with ModifierCompletion.Editor do begin
      SelText := '';
      L:= Length(Parameters.StopMask);
      if (CaretX > 0) and WideSameStr(Copy(LineText, CaretX-L, L), Parameters.StopMask) then begin
        CaretX:= CaretX - L;
        Value := '-' + Value;
      end else if not ((CaretX > 1) and (Lines[CaretY-1][CaretX-1] = '-')) then begin
        L:= WideLastPos(Parameters.StopMask, LineText); 
        if L > 0 then CaretX:= L;
        Value := '-' + Value;
      end;
    end;
end;

procedure TCommandsDataModule.actParameterCompletionExecute(
  Sender: TObject);
begin
  if Assigned(Screen.ActiveControl) and (Screen.ActiveControl is TSynedit) then begin
    ParameterCompletion.Editor := TSynEdit(Screen.ActiveControl);
    ParameterCompletion.ActivateCompletion;
  end;
end;

procedure TCommandsDataModule.actModifierCompletionExecute(
  Sender: TObject);
begin
  if Assigned(Screen.ActiveControl) and (Screen.ActiveControl is TSynedit) then begin
    ModifierCompletion.Editor := TSynEdit(Screen.ActiveControl);
    ModifierCompletion.ActivateCompletion;
  end;
end;

procedure TCommandsDataModule.actReplaceParametersExecute(Sender: TObject);
var
  i, j: Integer;
  S : string;
  OldCaret : TBufferCoord;
begin
  if Assigned(Screen.ActiveControl) and (Screen.ActiveControl is TSynedit) then begin
    with TSynEdit(Screen.ActiveControl) do begin
      OldCaret := CaretXY;
      if SelAvail then
        SelText:= Parameters.ReplaceInText(SelText)
      else try
        BeginUpdate;
        with Parameters do begin
          for i:= 0 to Lines.Count-1 do begin
            S:= Lines[i];
            j:= AnsiPos(StartMask, S);
            if j > 0 then begin
              BeginUndoBlock;
              try
                BlockBegin:= BufferCoord(j, i+1);
                BlockEnd:= BufferCoord(Length(S)+1, i+1);
                SelText:= ReplaceInText(Copy(S, j, MaxInt));
              finally
                EndUndoBlock;
              end;
            end;
          end;
        end;
      finally
        EndUpdate;
      end;
      CaretXY := OldCaret;
    end;
  end;
end;

type
  TCrackSynAutoComplete = class(TSynAutoComplete)
  end;

procedure TCommandsDataModule.actInsertTemplateExecute(Sender: TObject);
Var
  SynEdit : TSynEdit;
begin
  if Assigned(Screen.ActiveControl) and (Screen.ActiveControl is TSynedit) then begin
    SynEdit := TSynEdit(Screen.ActiveControl);
    CodeTemplatesCompletion.Execute(TCrackSynAutoComplete(CodeTemplatesCompletion).
      GetPreviousToken(SynEdit), SynEdit);
  end;
end;

procedure TCommandsDataModule.actHelpParametersExecute(Sender: TObject);
begin
  PyIDEMainForm.MenuHelpRequested := True;
  Application.HelpJump('parameters');
  PyIDEMainForm.MenuHelpRequested := False;
end;

procedure TCommandsDataModule.actHelpWebGroupSupportExecute(Sender: TObject);
begin
  OpenObject('http://groups.google.com/group/PyScripter');
end;

procedure TCommandsDataModule.actHelpWebProjectHomeExecute(Sender: TObject);
begin
  OpenObject('http://pyscripter.googlecode.com');
end;

procedure TCommandsDataModule.actHelpExternalToolsExecute(Sender: TObject);
begin
  PyIDEMainForm.MenuHelpRequested := True;
  Application.HelpJump('externaltools');
  PyIDEMainForm.MenuHelpRequested := False;
end;

procedure TCommandsDataModule.actHelpEditorShortcutsExecute(
  Sender: TObject);
begin
  PyIDEMainForm.MenuHelpRequested := True;
  Application.HelpJump('editorshortcuts');
  PyIDEMainForm.MenuHelpRequested := False;
end;

procedure TCommandsDataModule.actCustomizeParametersExecute(
  Sender: TObject);
begin
  with TCustomizeParams.Create(Self) do begin
    SetItems(CustomParams);
    if ShowModal = mrOK then begin
      GetItems(CustomParams);
      RegisterCustomParams;
    end;
    Free;
  end;
end;

procedure TCommandsDataModule.actCodeTemplatesExecute(Sender: TObject);
begin
  with TCodeTemplates.Create(Self) do begin
    //SetItems(CodeTemplatesCompletion.AutoCompleteList);
    CodeTemplateText := CodeTemplatesCompletion.AutoCompleteList.Text;
    if ShowModal = mrOK then
      CodeTemplatesCompletion.AutoCompleteList.Text := CodeTemplateText;
    Free;
  end;
end;

procedure TCommandsDataModule.actFileTemplatesExecute(Sender: TObject);
begin
  with TFileTemplatesDialog.Create(Self) do begin
    SetItems;
    if ShowModal = mrOK then
      GetItems;
    Free;
  end;
end;

procedure TCommandsDataModule.actConfigureToolsExecute(Sender: TObject);
begin
  if ConfigureTools(ToolsCollection) then
    PyIDEMainForm.SetupToolsMenu;
end;

procedure TCommandsDataModule.actFindFunctionExecute(Sender: TObject);
begin
  JumpToFunction;
end;

procedure TCommandsDataModule.actEditLineNumbersExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.Gutter.ShowLineNumbers := not
      GI_ActiveEditor.ActiveSynEdit.Gutter.ShowLineNumbers;
end;

procedure TCommandsDataModule.actEditWordWrapExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    GI_ActiveEditor.ActiveSynEdit.WordWrap := not GI_ActiveEditor.ActiveSynEdit.WordWrap;
end;

procedure TCommandsDataModule.actEditShowSpecialCharsExecute(
  Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) then
    if eoShowSpecialChars in GI_ActiveEditor.ActiveSynEdit.Options then
      GI_ActiveEditor.ActiveSynEdit.Options := GI_ActiveEditor.ActiveSynEdit.Options - [eoShowSpecialChars]
    else
      GI_ActiveEditor.ActiveSynEdit.Options := GI_ActiveEditor.ActiveSynEdit.Options + [eoShowSpecialChars]
end;

procedure TCommandsDataModule.actFindNextReferenceExecute(
  Sender: TObject);
var
  SearchOptions: TSynSearchOptions;
  SearchText : String;
  OldCaret : TBufferCoord;
begin
  if Assigned(GI_ActiveEditor) then with GI_ActiveEditor.ActiveSynEdit do begin
    SearchText :=  GetWordAtRowCol(CaretXY);
    if SearchText <> '' then begin
      OldCaret := CaretXY;

      SearchEngine := SynEditSearch;
      SearchOptions := [];
      if (Sender as TComponent).Tag = 1 then
        Include(SearchOptions, ssoBackwards)
      else
        CaretX := CaretX + 1;  //  So that we find the next identifier
      Include(SearchOptions, ssoMatchCase);
      Include(SearchOptions, ssoWholeWord);
      PyIDEMainForm.WriteStatusMsg('');
      if SearchReplace(SearchText, '', SearchOptions) = 0 then begin
        CaretXY := OldCaret;
        MessageBeep(MB_ICONASTERISK);
        PyIDEMainForm.WriteStatusMsg(WideFormat(_(SNotFound), [SearchText]));
      end else begin
        CaretXY := BlockBegin;
      end;
    end;
  end;
end;

type
  TCrackedCustomVirtualStingTree = class(TCustomVirtualStringTree)
  end;
  TCrackedCustomStringTreeOptions = class(TCustomStringTreeOptions)
  end;

procedure TCommandsDataModule.VirtualStringTreePaintText(
  Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
begin
  if SkinManager.IsDefaultSkin then Exit;
  with TCrackedCustomVirtualStingTree(Sender) do begin
    if (Column = FocusedColumn) or (toFullRowSelect in TCrackedCustomStringTreeOptions(TreeOptions).SelectionOptions) then
    begin
      if (Node = HotNode) or (vsSelected in Node.States) then
      begin
        TargetCanvas.Font.Color :=
          CurrentSkin.GetTextColor(skncListItem, CurrentSkin.GetState(True, False, Node = HotNode, vsSelected in Node.States));
      end;
    end;
  end;
end;

procedure TCommandsDataModule.VirtualStringTreeAdvancedHeaderDraw(Sender: TVTHeader;
  var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
Var
  R : TRect;
  State: TSpTBXSkinStatesType;
  DrawFormat: Cardinal;
  Text : WideString;
  TextSpace: Integer;
  Size: TSize;
  DC : HDC;
begin
  with PaintInfo do begin
    State := CurrentSkin.GetState(IsEnabled, IsDownIndex, IsHoverIndex, False);
    if ShowSortGlyph and not(IsHoverIndex or IsDownIndex) then
      State := sknsChecked;
  end;

  if hpeBackground in Elements then begin
    R := PaintInfo.PaintRectangle;
    if (PaintInfo.Column = nil) then begin
      SpDrawXPHeader(PaintInfo.TargetCanvas, R, False, False, SkinManager.GetSkinType);
    end else with PaintInfo do begin
      SpDrawXPHeader(PaintInfo.TargetCanvas, R, IsHoverIndex, IsDownIndex, SkinManager.GetSkinType );
    end;
  end;
  if (hpeText in Elements) and Assigned(PaintInfo.Column) then begin
    R := PaintInfo.TextRectangle;
    DC := PaintInfo.TargetCanvas.Handle;
    Text := PaintInfo.Column.Text;
    GetTextExtentPoint32W(DC, PWideChar(Text), Length(Text), Size);
    TextSpace := R.Right - R.Left;
    if TextSpace < Size.cx then
      Text := ShortenString(DC, Text, TextSpace);
    SetTextColor(DC, ColorToRGB(CurrentSkin.GetTextColor(skncHeader, State)));
    DrawFormat := DT_LEFT or DT_TOP or DT_NOPREFIX;
    if Sender.TreeView.UseRightToLeftReading then
      DrawFormat := DrawFormat + DT_RTLREADING;
    SetBkMode(DC, TRANSPARENT);
    Windows.DrawTextW(DC, PWideChar(Text), Length(Text), R, DrawFormat);
  end;
end;

procedure TCommandsDataModule.VirtualStringTreeBeforeCellPaint(
  Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
Var
  InnerRect, R: TRect;
  NodeWidth : integer;
  CurrentAlignment: TAlignment;
begin
  if SkinManager.IsDefaultSkin then Exit;
  if CellPaintMode <> cpmPaint then Exit;

  with TCrackedCustomVirtualStingTree(Sender), TargetCanvas do begin
    if (Column = FocusedColumn) or (toFullRowSelect in TCrackedCustomStringTreeOptions(TreeOptions).SelectionOptions) then
    begin
      if (vsSelected in Node.States) or (Node = HotNode) then
      begin
        if (toGridExtensions in TCrackedCustomStringTreeOptions(TreeOptions).MiscOptions) or
           (toFullRowSelect in TCrackedCustomStringTreeOptions(TreeOptions).SelectionOptions)
        then
          InnerRect := CellRect
        else begin
          InnerRect:= ContentRect;
          R := GetDisplayRect(Node, Column, True);
          NodeWidth := R.Right - R.Left;
          if Column <= NoColumn then
            CurrentAlignment := Alignment
          else
            CurrentAlignment := Header.Columns[Column].Alignment;
          case CurrentAlignment of
            taLeftJustify:
              with InnerRect do
                if Left + NodeWidth < Right then
                  Right := Left + NodeWidth;
            taCenter:
              with InnerRect do
                if (Right - Left) > NodeWidth then
                begin
                  Left := (Left + Right - NodeWidth) div 2;
                  Right := Left + NodeWidth;
                end;
            taRightJustify:
              with InnerRect do
                if (Right - Left) > NodeWidth then
                  Left := Right - NodeWidth;
          end;
        end;
        if not IsRectEmpty(InnerRect) then begin
          TargetCanvas.FillRect(InnerRect);
          SpDrawXPListItemBackground(TargetCanvas, InnerRect, vsSelected in Node.States, Node = HotNode,
            False, SkinManager.GetSkinType, True, False);
        end;
      end;
    end;
  end;
end;

procedure TCommandsDataModule.VirtualStringTreeDrawQueryElements(
  Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
  var Elements: THeaderPaintElements);
begin
  if SkinManager.IsDefaultSkin then
    Elements := []
  else
    Elements := [hpeBackground, hpeText];
end;

procedure TCommandsDataModule.actCheckForUpdatesExecute(Sender: TObject);
begin
  try
    ProgramVersionCheck.LocalDirectory := UserDataDir + 'Updates';
    ProgramVersionCheck.Execute;
  except
    if Assigned(Sender) then
      raise
    else
      Exit;
  end;

  if Assigned(Sender) and not ProgramVersionCheck.IsRemoteProgramVersionNewer then
    if ProgramVersionCheck.DownloadError <> '' then
      WideMessageDlg(_(SErrorWhileDownload) +
        ProgramVersionCheck.DownloadError, mtError, [mbOK], 0)
    else
      WideMessageDlg(_(SCurrentVersionUptodate), mtInformation, [mbOK], 0);
  PyIDEOptions.DateLastCheckedForUpdates := Now;
end;

procedure TCommandsDataModule.GetEditorUserCommand(AUserCommand: Integer;
  var ADescription: String);
begin
  if AUserCommand = ecCodeCompletion then
    ADescription := 'Code Completion'
  else if AUserCommand = ecParamCompletion then
    ADescription := 'Param Completion';
end;

procedure TCommandsDataModule.GetEditorAllUserCommands(ACommands: TStrings);
begin
  ACommands.AddObject('Code Completion', TObject(ecCodeCompletion));
  ACommands.AddObject('Param Completion', TObject(ecParamCompletion));
end;

function TCommandsDataModule.DoSearchReplaceText(SynEdit : TSynEdit;
      AReplace, ABackwards : Boolean ; IsIncremental : Boolean = False) : integer;

  function EndReached(ABackWards, SelectionOnly : Boolean) : Widestring;
  begin
    if ABackwards then
      Result := WideFormat(_(SReachedTheStart),
              [iif(SelectionOnly, _(SOfTheSelection), _(SOfTheDocument))])
    else
      Result := WideFormat(_(SReachedTheEnd),
              [iif(SelectionOnly, _(SOfTheSelection), _(SOfTheDocument))]);
  end;

var
  Options: TSynSearchOptions;
  IsNewSearch : Boolean;
  MsgText : WideString;
  OldCaretXY, OldBlockBegin, OldBlockEnd : TBufferCoord;
  dlgID : integer;
  OldNoReplaceCount : integer;
begin
  Result := 0;
  OldNoReplaceCount := 0;

  if EditorSearchOptions.SearchText = '' then Exit; //Nothing to Search
  if PyIDEOptions.AutoHideFindToolbar and not IsIncremental then begin
    PyIDEMainForm.FindToolbar.Visible := False;
  end;
  if EditorSearchOptions.UseRegExp then
    SynEdit.SearchEngine := SynEditRegexSearch
  else
    SynEdit.SearchEngine := SynEditSearch;

  IsNewSearch := (EditorSearchOptions.InitBlockBegin.Char = 0) or
                 (EditorSearchOptions.BackwardSearch <> ABackwards);
  if IsNewSearch then
    EditorSearchOptions.NewSearch(SynEdit, ABackwards);

  if AReplace then begin
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll];
    EditorSearchOptions.NoReplaceCount := 0;
  end else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  if EditorSearchOptions.SearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if not EditorSearchOptions.TempSearchFromCaret then
    Include(Options, ssoEntireScope);
  if EditorSearchOptions.SearchWholeWords then
    Include(Options, ssoWholeWord);

  if EditorSearchOptions.TempSelectionOnly then with EditorSearchOptions do begin
    Options := Options + [ssoSelectedOnly, ssoEntireScope];
    // we need to restrict the scope of search within the orginal selection
    if not IsNewSearch then begin
      OldCaretXY := SynEdit.CaretXY;
      OldBlockBegin := SynEdit.BlockBegin;
      OldBlockEnd := SynEdit.BlockEnd;
      if ABackwards then
        SynEdit.SetCaretAndSelection(SynEdit.BlockBegin, InitBlockBegin, SynEdit.BlockBegin)
      else
        SynEdit.SetCaretAndSelection(SynEdit.CaretXY, SynEdit.CaretXY, InitBlockEnd);
    end;
  end;

  with EditorSearchOptions do begin
    if WrappedSearch and CanWrapSearch then begin
      // we need to restrict the scope of search within the remaining space
      CanWrapSearch := False;  //Only do this block once
      TempSelectionOnly := True;
      Options := Options + [ssoSelectedOnly, ssoEntireScope];
      if ABackwards then begin
        InitBlockBegin := InitCaretXY;
        InitCaretXY := InitBlockEnd;
      end else begin
        InitBlockEnd := InitCaretXY;
        InitCaretXY := InitBlockBegin;
      end;
      SynEdit.SetCaretAndSelection(InitCaretXY, InitBlockBegin, InitBlockEnd);
      if (ssoReplace in Options) and (LastReplaceAction = raReplaceAll) then
        Options := Options - [ssoPrompt];
    end;
  end;

  PyIDEMainForm.WriteStatusMsg('');

  if (EditorSearchOptions.TempSelectionOnly and
     (SynEdit.BlockBegin.Char = Synedit.BlockEnd.Char) and
     (SynEdit.BlockBegin.Line = Synedit.BlockEnd.Line))
  then
    Result := 0
  else
    try
        Result := SynEdit.SearchReplace(EditorSearchOptions.SearchText,
         EditorSearchOptions.ReplaceText, Options);
    except
      on E: ERegExpr do begin
        Result := 0;
        PyIDEMainForm.WriteStatusMsg(WideFormat(_(SInvalidRegularExpression), [E.Message]));
        Exit;
      end;
    end;

  if (Result = 0) or (ssoReplace in Options) then with EditorSearchOptions do begin
    MessageBeep(MB_ICONASTERISK);
    TempSearchFromCaret := False;
    if TempSelectionOnly and not WrappedSearch then
      // Restore the original selection
      SynEdit.SetCaretAndSelection(InitCaretXY, InitBlockBegin, InitBlockEnd)
    else if TempSelectionOnly and WrappedSearch and not (ssoReplace in Options) then
      SynEdit.SetCaretAndSelection(OldCaretXY, OldBlockBegin, OldBlockEnd);

    if WrappedSearch then begin
      MsgText := _(SStartReached);
      PyIDEMainForm.WriteStatusMsg(MsgText);
      DSAMessageDlg(dsaSearchStartReached, 'PyScripter', MsgText,
         mtInformation, [mbOK], 0, dckActiveForm, 0, mbOK);
      InitSearch;
    end else begin
      MsgText := EndReached(ABackwards, TempSelectionOnly);
      if Result = 0 then
        PyIDEMainForm.WriteStatusMsg(WideFormat(_(SNotFound), [SearchText]))
      else
        PyIDEMainForm.WriteStatusMsg(MsgText);
      if CanWrapSearch and (LastReplaceAction <> raCancel) then begin
        dlgID := iff(ssoReplace in Options, dsaReplaceFromStart, dsaSearchFromStart);
        MsgText :=  WideFormat(MsgText + sLineBreak + _(SContinueSearch),
          [iff(ssoReplace in Options, _(STheSearchAndReplace), _(STheSearch)),
           iif(ABackwards, _(SFromTheEnd), _(SFromTheStart))]);

        if  IsIncremental or (DSAMessageDlg(dlgID, 'PyScripter', MsgText,
           mtConfirmation, [mbYes, mbNo], 0, dckActiveForm, 0, mbYes, mbNo) = mrYes) then
        begin
          WrappedSearch := True;
          OldNoReplaceCount := NoReplaceCount;
          Result := Result + DoSearchReplaceText(SynEdit,  AReplace, ABackwards, IsIncremental);
        end;
      end else begin
        MsgText := _(SStartReached);
        if (Result = 0) and not (ssoReplace in Options) then
          PyIDEMainForm.WriteStatusMsg(WideFormat(_(SNotFound), [SearchText]))
        else
          PyIDEMainForm.WriteStatusMsg(MsgText);
        InitSearch;
      end;
      if (ssoReplace in Options) and (Result > 0) then begin
        MsgText := WideFormat(_(SItemsReplaced), [Result, Result - NoReplaceCount - OldNoReplaceCount]);
        PyIDEMainForm.WriteStatusMsg(MsgText);
        DSAMessageDlg(dsaReplaceNumber, 'PyScripter', MsgText,
           mtInformation, [mbOK], 0, dckActiveForm, 0, mbOK);
      end;
    end;
  end else
    EditorSearchOptions.TempSearchFromCaret := True;

  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

function TCommandsDataModule.FileIsPythonSource(FileName: WideString): Boolean;
begin
  Result :=  GetHighlighterForFile(FileName) = SynPythonSyn;
end;

function TCommandsDataModule.FindSearchTarget: ISearchCommands;
Var
  Editor : IEditor;
begin
  Result := GI_SearchCmds;
  if not Assigned(GI_SearchCmds) then begin
    if EditorSearchOptions.InterpreterIsSearchTarget and CanActuallyFocus(PythonIIForm.SynEdit) then
      Result := PythonIIForm
    else begin
      Editor := PyIDEMainForm.GetActiveEditor;
      if Assigned(Editor) then
        Result := Editor as ISearchCommands
    end;
  end;
end;

procedure TCommandsDataModule.ShowSearchReplaceDialog(SynEdit : TSynEdit; AReplace: boolean);
Var
  S : WideString;
begin
  EditorSearchOptions.InitSearch;
  with PyIDEMainForm do begin
    tbiReplaceSeparator.Visible := AReplace;
    tbiReplaceLabel.Visible := AReplace;
    tbiReplaceText.Visible := AReplace;
    tbiReplaceExecute.Visible := AReplace;
    if AReplace then begin
      tbiReplaceText.Text := EditorSearchOptions.ReplaceText;
      tbiReplaceText.Items.CommaText := EditorSearchOptions.ReplaceTextHistory;
      PyIDEMainForm.tbiReplaceTextChange(Self);
    end;
    FindToolbar.Visible := True;
    FindToolbar.View.CancelMode;
    // start with last search text
    tbiSearchText.Text := EditorSearchOptions.SearchText;
    if EditorSearchOptions.SearchTextAtCaret then
    begin
      // if something is selected search for that text
      if SynEdit.SelAvail and (SynEdit.BlockBegin.Line = SynEdit.BlockEnd.Line)
      then
        tbiSearchText.Text := SynEdit.SelText
      else begin
        S := SynEdit.GetWordAtRowCol(SynEdit.CaretXY);
        if S <> '' then
          tbiSearchText.Text := S;
      end;
    end;
    tbiSearchText.Items.CommaText := EditorSearchOptions.SearchTextHistory;
    PyIDEMainForm.tbiSearchTextChange(Self);

    if CanActuallyFocus(tbiSearchText) then
       tbiSearchText.SetFocus;
  end;
end;

procedure TCommandsDataModule.SynEditReplaceText(Sender: TObject; const ASearch,
  AReplace: WideString; Line, Column: Integer; var Action: TSynReplaceAction);
Var
  APos: TPoint;
  EditRect: TRect;
  SynEdit : TSynEdit;
begin
  SynEdit := Sender as TSynEdit;
  if ASearch = AReplace then
    Action := raSkip
  else begin
    APos := SynEdit.ClientToScreen(
      SynEdit.RowColumnToPixels(
      SynEdit.BufferToDisplayPos(
      BufferCoord(Column, Line) ) ) );
    EditRect := SynEdit.ClientRect;
    EditRect.TopLeft := SynEdit.ClientToScreen(EditRect.TopLeft);
    EditRect.BottomRight := SynEdit.ClientToScreen(EditRect.BottomRight);

    if ConfirmReplaceDialog = nil then begin
      ConfirmReplaceDialog := TConfirmReplaceDialog.Create(Application);
      fConfirmReplaceDialogRect := ConfirmReplaceDialog.BoundsRect;
    end;
    if EqualRect(fConfirmReplaceDialogRect, ConfirmReplaceDialog.BoundsRect) then begin
      ConfirmReplaceDialog.PrepareShow(EditRect, APos.X, APos.Y,
        APos.Y + SynEdit.LineHeight, ASearch);
      fConfirmReplaceDialogRect := ConfirmReplaceDialog.BoundsRect;
    end else
      fConfirmReplaceDialogRect := Rect(0, 0, 0, 0);

    case ConfirmReplaceDialog.ShowModal of
      mrYes:      Action := raReplace;
      mrYesToAll: Action := raReplaceAll;
      mrNo:       Action := raSkip;
      else        Action := raCancel;
    end;
  end;
  EditorSearchOptions.LastReplaceAction := Action;
  if Action in [raSkip, raCancel] then
    Inc(EditorSearchOptions.fNoReplaceCount);
end;

resourcestring
  S_ERROR_NO_ERROR_STRING = 'Unspecified WinInet error';

function TCommandsDataModule.ProgramVersionHTTPLocationLoadFileFromRemote(
  AProgramVersionLocation: TJvProgramVersionHTTPLocation; const ARemotePath,
  ARemoteFileName, ALocalPath, ALocalFileName: string): string;

  function FileExistsNoDir(AFileName: string): Boolean;
  begin
    Result := FileExists(AFileName) and not DirectoryExists(AFileName);
  end;

  function GetLastErrorString: string;
  {
    Returns last error string, strangely enough.
  }
  var
    nLastError,
    nBufLength:   DWORD;
    pLastError:   PChar;
  begin
    nBufLength := INTERNET_MAX_PATH_LENGTH;
    pLastError := StrAlloc(INTERNET_MAX_PATH_LENGTH);
    try
      If not(InternetGetLastResponseInfo(nLastError, pLastError, nBufLength))
      or (StrLen(pLastError) = 0) then
        result := S_ERROR_NO_ERROR_STRING
      else
        result := StrPas(pLastError);
    finally
      StrDispose(pLastError);
    end;
  end;

  procedure CheckWinInetError(Error: Boolean);
  begin
    if Error then
      raise Exception.Create(GetLastErrorString);
  end;

var
  ResultStream: TFileStream;
  LocalFileName, URL : string;
  hNet, hUrl: HINTERNET;
  dwBytesAvail,
  dwBytesRead:  DWORD;
  Buffer: string;
begin
  Result := '';
  if (DirectoryExists(ALocalPath) or (ALocalPath = '')) then
    if ALocalFileName = '' then
      LocalFileName := PathAppend(ALocalPath, ARemoteFileName)
    else
      LocalFileName := PathAppend(ALocalPath, ALocalFileName)
  else
    Exit;

  if Copy(ARemotePath, Length(ARemotePath), 1) <> '/' then
    URL := ARemotePath + '/' + ARemoteFileName
  else
    URL := ARemotePath + ARemoteFileName;

  try
    ResultStream := TFileStream.Create(LocalFileName, fmCreate);
    try
      // initialize WinInet
      hNet := InternetOpen(
        'PyScripter',
        INTERNET_OPEN_TYPE_PRECONFIG,
        nil, nil, 0);
      CheckWinInetError(hNet = nil);

      try
        // open the file
        hUrl := InternetOpenUrl(hNet,
          PChar(URL), nil, 0,
          INTERNET_FLAG_PRAGMA_NOCACHE, 0);
        CheckWinInetError(hUrl = nil);

        try
          repeat
            CheckWinInetError(not InternetQueryDataAvailable(
              hUrl, dwBytesAvail, 0, 0));
            if dwBytesAvail <> 0 then begin
              SetLength(Buffer, dwBytesAvail);
              CheckWinInetError(not InternetReadFile(hUrl,
                PChar(Buffer),
                dwBytesAvail, dwBytesRead));
              CheckWinInetError(dwBytesAvail <> dwBytesRead);
              ResultStream.write(Buffer[1], dwBytesRead);
            end;
          until (dwBytesAvail = 0) or ((ProgramVersionCheck.Thread.Count > 0) and
            ProgramVersionCheck.Thread.Terminated);
        finally
          InternetCloseHandle(hUrl);
        end;

      finally
        InternetCloseHandle(hNet);
      end;
    finally
      ResultStream.Free;
    end;
  except
    on E: Exception do
      ProgramVersionHTTPLocation.DownloadError := E.Message;
  end;

  if FileExists(LocalFileName) then
    if (ProgramVersionHTTPLocation.DownloadError <> '') or
         ((ProgramVersionCheck.Thread.Count > 0) and
            ProgramVersionCheck.Thread.Terminated)
    then
      FileDelete(LocalFileName)
    else
      Result := LocalFileName;                        
end;

initialization
  EditorSearchOptions := TEditorSearchOptions.Create;
  EditorSearchOptions.fSearchTextAtCaret := True;
  EditorSearchOptions.fSearchFromCaret := True;
  EditorSearchOptions.fIncrementalSearch := True;
  EditorSearchOptions.InitSearch;
  // getText stuff
  // Things that cannot be translated
  TP_GlobalIgnoreClass(TJvMultiStringHolder);
  TP_GlobalIgnoreClass(TSynAutoComplete);
  TP_GlobalIgnoreClass(TSpTBXMRUListItem);
  TP_GlobalIgnoreClass(TSynCustomHighLighter);
  TP_GlobalIgnoreClass(TCommonDialog);
  TP_GlobalIgnoreClass(TJvProgramVersionCheck);
  TP_GlobalIgnoreClass(TJvProgramVersionHTTPLocation);
  TP_GlobalIgnoreClass(TJvCustomAppStorage);
  // VCL stuff
  TP_GlobalIgnoreClassProperty(TAction,'Category');
  TP_GlobalIgnoreClassProperty(TControl,'HelpKeyword');
  TP_GlobalIgnoreClass(TFont);
finalization
  EditorSearchOptions.Free;
end.













