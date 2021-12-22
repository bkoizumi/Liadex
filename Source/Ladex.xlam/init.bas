Attribute VB_Name = "init"
Option Explicit


'���[�N�u�b�N�p�ϐ�------------------------------
Public BK_ThisBook          As Workbook
Public targetBook           As Workbook

'���[�N�V�[�g�p�ϐ�------------------------------
Public targetSheet          As Worksheet

Public BK_sheetSetting      As Worksheet
Public BK_sheetNotice       As Worksheet
Public BK_sheetStyle        As Worksheet
Public BK_sheetTestData     As Worksheet
Public BK_sheetRibbon       As Worksheet
Public BK_sheetFavorite     As Worksheet
Public BK_sheetStamp        As Worksheet
Public BK_sheetHighLight    As Worksheet
Public BK_sheetHelp         As Worksheet
Public BK_sheetFunction     As Worksheet
Public BK_sheetSheetList    As Worksheet

'�O���[�o���ϐ�----------------------------------
Public Const thisAppName    As String = "Ladex"
Public Const thisAppVersion As String = "V1.0.0"
Public Const RelaxTools     As String = "Relaxtools.xlam"

Public funcName             As String
Public resetVal             As String
Public runFlg               As Boolean
Public PrgP_Cnt             As Long
Public PrgP_Max             As Long



'���W�X�g���o�^�p�L�[----------------------------
Public Const RegistryKey    As String = "Ladex"
Public RegistrySubKey       As String


'�ݒ�l�ێ�--------------------------------------
Public BK_setVal            As Object
Public sampleDataList       As Object


'�t�@�C��/�f�B���N�g���֘A-----------------------
Public logFile              As String
Public LadexDir             As String


'�������Ԍv���p----------------------------------
Public StartTime            As Date
Public StopTime             As Date



'���{���֘A--------------------------------------
Public BK_ribbonUI          As Office.IRibbonUI
Public BK_ribbonVal         As Object
Public BKT_rbPressed        As Boolean

Public BKh_rbPressed        As Boolean
Public BKz_rbPressed        As Boolean
Public BKcf_rbPressed       As Boolean



'���[�U�[�֐��֘A--------------------------------
Public arryHollyday()       As Date

'�Y�[���֘A--------------------------------------
Public defaultZoomInVal     As String




'**************************************************************************************************
' * �ݒ����
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function unsetting(Optional Flg As Boolean = True)
  Dim line As Long, endLine As Long, colLine As Long, endColLine As Long
  Const funcName As String = "init.unsetting"

  Set BK_ThisBook = Nothing
  
  '���[�N�V�[�g���̐ݒ�
  Set BK_sheetSetting = Nothing
  Set BK_sheetNotice = Nothing
  Set BK_sheetStyle = Nothing
  Set BK_sheetTestData = Nothing
  Set BK_sheetRibbon = Nothing
  Set BK_sheetFavorite = Nothing

  '�ݒ�l�ǂݍ���
  Set BK_setVal = Nothing
  Set BK_ribbonVal = Nothing
  
  logFile = ""
  LadexDir = ""
  
  If Flg = True Then
    runFlg = False
  End If
  
  Exit Function
'�G���[������------------------------------------
catchError:
  Call Library.showDebugForm(funcName, " [" & Err.Number & "]" & Err.Description, "Error")
  Call Library.errorHandle
End Function

'**************************************************************************************************
' * �ݒ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function setting(Optional reCheckFlg As Boolean)
  Dim line As Long, endLine As Long
  Const funcName As String = "init.setting"
  
  '�����J�n--------------------------------------
  On Error GoTo catchError
'  ThisWorkbook.Save
'  If Workbooks.count = 0 Then
'    Call MsgBox("�u�b�N���J����Ă��܂���", vbCritical, thisAppName)
'    Call Library.endScript
'    End
'  End If
  '----------------------------------------------

  If LadexDir = "" Or BK_setVal Is Nothing Or reCheckFlg = True Then
    Call init.unsetting(False)
  Else
    Exit Function
  End If

  '���W�X�g���֘A
  RegistrySubKey = "Main"
  
  '�u�b�N�̐ݒ�
  Set BK_ThisBook = ThisWorkbook
  
  '���[�N�V�[�g���̐ݒ�
  Set BK_sheetSetting = BK_ThisBook.Worksheets("�ݒ�")
  Set BK_sheetNotice = BK_ThisBook.Worksheets("Notice")
  Set BK_sheetStyle = BK_ThisBook.Worksheets("Style")
  Set BK_sheetTestData = BK_ThisBook.Worksheets("testData")
'  Set BK_sheetRibbon = BK_ThisBook.Worksheets("Ribbon")
  Set BK_sheetFavorite = BK_ThisBook.Worksheets("Favorite")
  Set BK_sheetStamp = BK_ThisBook.Worksheets("Stamp")
  Set BK_sheetHighLight = BK_ThisBook.Worksheets("HighLight")
  Set BK_sheetHelp = BK_ThisBook.Worksheets("Help")
  Set BK_sheetFunction = BK_ThisBook.Worksheets("Function")
  Set BK_sheetSheetList = BK_ThisBook.Worksheets("SheetList")
  
 
  '�ݒ�l�ǂݍ���--------------------------------
  Set BK_setVal = Nothing
  Set BK_setVal = CreateObject("Scripting.Dictionary")
  
  endLine = BK_sheetSetting.Cells(Rows.count, 1).End(xlUp).Row
  If endLine = 0 Then
    endLine = 11
  End If
  
  For line = 3 To endLine
    If BK_sheetSetting.Range("A" & line) <> "" Then
      BK_setVal.add BK_sheetSetting.Range("A" & line).Text, BK_sheetSetting.Range("B" & line).Text
    End If
  Next
    
  Dim wsh As Object
  Set wsh = CreateObject("WScript.Shell")
  LadexDir = wsh.SpecialFolders("AppData") & "\Bkoizumi\Ladex"
  logFile = LadexDir & "\log\ExcelMacro.log"
  Set wsh = Nothing
  
  Exit Function
  
'�G���[������------------------------------------
catchError:
  Debug.Print Format(Now(), "yyyy-mm-dd hh:nn:ss") & "  [ERROR]" & funcName
  Debug.Print Format(Now(), "yyyy-mm-dd hh:nn:ss") & "  " & Err.Description
End Function

'**************************************************************************************************
' * ���O��`
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function ���O��`()
  Dim line As Long, endLine As Long, colLine As Long, endColLine As Long
  Dim Name As Object
  Const funcName As String = "init.���O��`"
  
  On Error GoTo catchError

  '���O�̒�`���폜
  For Each Name In Names
    If Name.Visible = False Then
      Name.Visible = True
    End If
    If Not Name.Name Like "*!Print_Area" And Not Name.Name Like "*!Print_Titles" And _
      Not Name.Name Like "Slc*" And Not Name.Name Like "Pvt*" And Not Name.Name Like "Tbl*" Then
      Name.delete
    End If
  Next
  
  'VBA�p�̐ݒ�
  For line = 3 To BK_sheetSetting.Cells(Rows.count, 1).End(xlUp).Row
    If BK_sheetSetting.Range("A" & line) <> "" Then
      BK_sheetSetting.Range("B" & line).Name = BK_sheetSetting.Range("A" & line)
    End If
  Next
  
  'Book�p�̐ݒ�
  BK_sheetSetting.Range("D3:D" & BK_sheetSetting.Cells(Rows.count, 6).End(xlUp).Row).Name = BK_sheetSetting.Range("D2")
  

  Exit Function
'�G���[������------------------------------------
catchError:
  Debug.Print Format(Now(), "yyyy-mm-dd hh:nn:ss") & "  [ERROR]" & funcName
  Debug.Print Format(Now(), "yyyy-mm-dd hh:nn:ss") & "  " & Err.Description
End Function
