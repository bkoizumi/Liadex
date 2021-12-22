Attribute VB_Name = "Ctl_RbnMaint"
Option Explicit

'**************************************************************************************************
' * Copy
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function �V�[�g�ǉ�()
  Call init.setting
  ThisWorkbook.Worksheets.add.Name = "SheetList"
  ThisWorkbook.Save
End Function


'==================================================================================================
Function �V�[�g�폜()
  Call init.setting
  Application.DisplayAlerts = False
  
  ThisWorkbook.Sheets("HighLight").delete
  
  Application.DisplayAlerts = True
  ThisWorkbook.Save
End Function


'==================================================================================================
Function ���̑�()
  Dim line As Long, endLine As Long
  
  Call init.setting(True)
  BK_ThisBook.Sheets("Help").Activate
'  Cells.Select
'  Selection.ColumnWidth = 5
  
'  BK_sheetHighLight.Range("N5").Select
'  BK_sheetHighLight.Range("N5").ClearComments
'  BK_sheetHighLight.Range("N5").AddComment
'  BK_sheetHighLight.Range("N5").Comment.Visible = False
'  BK_sheetHighLight.Range("N5").Comment.Text Text:="Sample�R�����g" & Chr(10) & "Sample�R�����g" & Chr(10) & "Sample�R�����g "
'
'  BK_sheetHighLight.Range("N5").Comment.Visible = True
  
  
  BK_sheetHelp.Cells.ColumnWidth = 3
  BK_sheetHelp.Cells.RowHeight = 15
  
  endLine = BK_sheetHelp.Cells(Rows.count, 1).End(xlUp).Row
  For line = 1 To endLine
    If BK_sheetHelp.Range("A" & line) <> "" Then
      BK_sheetHelp.Cells.RowHeight = 20
    End If
  Next
  
  
  ThisWorkbook.Save
End Function

'==================================================================================================
Function OptionSheetImport()
  Dim line As Long, endLine As Long
  Dim objShp
  
  Call init.setting
  Set targetBook = Workbooks("�����e�i���X�p.xlsm")

  targetBook.Sheets("�ݒ�").Columns("A:Z").Copy ThisWorkbook.Worksheets("�ݒ�").Range("A1")
  targetBook.Sheets("Notice").Columns("A:Z").Copy ThisWorkbook.Worksheets("Notice").Range("A1")
  targetBook.Sheets("Style").Columns("A:Z").Copy ThisWorkbook.Worksheets("Style").Range("A1")
  targetBook.Sheets("testData").Columns("A:Z").Copy ThisWorkbook.Worksheets("testData").Range("A1")
  targetBook.Sheets("Favorite").Columns("A:Z").Copy ThisWorkbook.Worksheets("Favorite").Range("A1")
  targetBook.Sheets("Function").Columns("A:Z").Copy ThisWorkbook.Worksheets("Function").Range("A1")
  
  
  Application.DisplayAlerts = False
  
  '�n�C���C�g�A�R�����g�v���r���[�p--------------
  ThisWorkbook.Sheets("HighLight").delete
  ThisWorkbook.Worksheets.add.Name = "HighLight"
  ThisWorkbook.Sheets("HighLight").Cells.ColumnWidth = 3.86
  ThisWorkbook.Sheets("HighLight").Cells.RowHeight = 15
  targetBook.Sheets("HighLight").Columns("A:Z").Copy ThisWorkbook.Worksheets("HighLight").Range("A1")
  
  
  '�w���v�V�[�g�ҏW------------------------------
  'ThisWorkbook.Sheets("Help").delete
  'ThisWorkbook.Worksheets.add.Name = "Help"
  ThisWorkbook.Sheets("Help").Cells.ColumnWidth = 3
  ThisWorkbook.Sheets("Help").Cells.RowHeight = 15
  
  ThisWorkbook.Worksheets("Help").Cells.delete Shift:=xlUp
  For Each objShp In ThisWorkbook.Worksheets("Help").Shapes
    objShp.delete
  Next
  
  targetBook.Sheets("Help").Columns("A:AZ").Copy ThisWorkbook.Worksheets("Help").Range("A1")
  
  endLine = ThisWorkbook.Sheets("Help").Cells(Rows.count, 1).End(xlUp).Row
'  For line = 1 To endLine
'    If ThisWorkbook.Sheets("Help").Range("A" & line) <> "" Then
'      ThisWorkbook.Sheets("Help").Cells.RowHeight = 20
'    End If
'  Next
  
  '�X�^���v�V�[�g�ҏW----------------------------
  ThisWorkbook.Sheets("Stamp").delete
  ThisWorkbook.Worksheets.add.Name = "Stamp"
  targetBook.Sheets("Stamp").Columns("A:AP").Copy ThisWorkbook.Worksheets("Stamp").Range("A1")
    
  'Call Library.showDebugForm(ThisWorkbook.Worksheets("Ribbon").Range("C39"))
  
  Application.DisplayAlerts = True
  ThisWorkbook.Save
  Set targetBook = Nothing
End Function


'==================================================================================================
Function OptionSheetExport()

  Call init.setting
  Set targetBook = Workbooks("�����e�i���X�p.xlsm")
  
  ThisWorkbook.Sheets("�ݒ�").Columns("A:AA").Copy targetBook.Worksheets("�ݒ�").Range("A1")
  ThisWorkbook.Sheets("Notice").Columns("A:B").Copy targetBook.Worksheets("Notice").Range("A1")
  ThisWorkbook.Sheets("Style").Columns("A:J").Copy targetBook.Worksheets("Style").Range("A1")
  ThisWorkbook.Sheets("testData").Columns("A:P").Copy targetBook.Worksheets("testData").Range("A1")
  ThisWorkbook.Worksheets("Favorite").Columns("A:C").Copy targetBook.Sheets("Favorite").Range("A1")
  ThisWorkbook.Worksheets("Function").Columns("A:Z").Copy targetBook.Sheets("Function").Range("A1")
  ThisWorkbook.Worksheets("SheetList").Columns("A:Z").Copy targetBook.Sheets("SheetList").Range("A1")
  
'  Call Library.showDebugForm(ThisWorkbook.Worksheets("Ribbon").Range("A2"))
  
  targetBook.Save
  ThisWorkbook.Save
  Set targetBook = Nothing
End Function

