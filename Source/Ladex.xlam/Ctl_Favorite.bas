Attribute VB_Name = "Ctl_Favorite"
Option Explicit

'**************************************************************************************************
' * お気に入り
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function getList()
  Dim tmp, i As Long, buf As String
  
  Call init.setting
  Call Library.delSheetData(LadexSh_Favorite, 2)
  tmp = GetAllSettings(thisAppName, "FavoriteList")
  
  If Not IsEmpty(tmp) Then
    For i = 0 To UBound(tmp)
      LadexSh_Favorite.Range("A" & i + 2) = tmp(i, 1)
    Next i
  End If
End Function


'==================================================================================================
Function addList()

  Dim line As Long, endLine As Long
  
  Call init.setting
  endLine = LadexSh_Favorite.Cells(Rows.count, 1).End(xlUp).Row

  Call Library.delRegistry("FavoriteList")
  
  For line = 2 To endLine
    Call Library.setRegistry("FavoriteList", "Favorite" & line - 1, LadexSh_Favorite.Range("A" & line))
  Next
End Function


'==================================================================================================
'お気に入り追加
Function add(Optional filePath As String)

  Dim line As Long, endLine As Long
  
  Call init.setting
  Call Ctl_Favorite.getList
  line = LadexSh_Favorite.Cells(Rows.count, 1).End(xlUp).Row + 1
  
  If filePath = "" Then
    filePath = ActiveWorkbook.FullName
  End If
  LadexSh_Favorite.Range("A" & line) = filePath
  
  Call addList

End Function


'==================================================================================================
'詳細表示
Function detail()
  Dim line As Long, endLine As Long
  Dim regLists As Variant
  Dim topPosition As Long, leftPosition As Long
  
  On Error GoTo catchError
  If Workbooks.count = 0 Then
    Call MsgBox("ブックが開かれていません", vbCritical, thisAppName)
    Exit Function
  End If
  
  Call getList
  With Frm_Favorite
    .Show vbModeless
  End With
  Call RefreshListBox
  
  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:
    Call Library.showDebugForm(funcName, " [" & Err.Number & "]" & Err.Description, "Error")
End Function



'==================================================================================================
Function RefreshListBox()
  Dim line As Long, endLine As Long
  Dim FSO As Object
  
  Const funcName As String = "Ctl_Favorite.RefreshListBox"
  
  Call init.setting
  Call Library.showDebugForm(funcName, , "start1")
  
  
  Set FSO = CreateObject("Scripting.FileSystemObject")
  
  endLine = LadexSh_Favorite.Cells(Rows.count, 1).End(xlUp).Row
  
  Frm_Favorite.Lst_Favorite.Clear
  For line = 2 To endLine
    Frm_Favorite.Lst_Favorite.AddItem FSO.GetBaseName(LadexSh_Favorite.Range("A" & line))
    
    Call Library.showDebugForm(LadexSh_Favorite.Range("A" & line), , "debug")
  Next
  Set FSO = Nothing
  
  'ThisWorkbook.Save
End Function


'**************************************************************************************************
' * フォーム上での右クリック
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function moveTop()
  Dim line As Long
  Dim filePath As String
  
  If Frm_Favorite.Lst_Favorite.ListIndex = 0 Then
    Exit Function
  End If
  
  Call init.setting
  
  line = Frm_Favorite.Lst_Favorite.ListIndex + 2
  
  LadexSh_Favorite.Range("A" & line).Cut
  LadexSh_Favorite.Range("A" & 2).Insert Shift:=xlDown
  
  Call RefreshListBox
End Function


'==================================================================================================
Function moveUp()
  Dim line As Long
  Dim filePath As String
  
  Call init.setting
  line = Frm_Favorite.Lst_Favorite.ListIndex + 2
  
  LadexSh_Favorite.Range("A" & line).Cut
  LadexSh_Favorite.Range("A" & line - 1).Insert Shift:=xlDown
  
  Call RefreshListBox
End Function


'==================================================================================================
Function moveDown()
  Dim line As Long, endLine As Long
  Dim filePath As String
  
  Call init.setting
  line = Frm_Favorite.Lst_Favorite.ListIndex + 2
  endLine = LadexSh_Favorite.Cells(Rows.count, 1).End(xlUp).Row
  
  If line >= endLine Then
    Exit Function
  End If
  LadexSh_Favorite.Range("A" & line).Cut
  LadexSh_Favorite.Range("A" & line + 2).Insert Shift:=xlDown
  
  Call RefreshListBox
End Function


'==================================================================================================
Function moveBottom()
  Dim line As Long, endLine As Long
  Dim filePath As String
  
  Call init.setting
  line = Frm_Favorite.Lst_Favorite.ListIndex + 2
  endLine = LadexSh_Favorite.Cells(Rows.count, 1).End(xlUp).Row
  
  If line >= endLine Then
    Exit Function
  End If
  LadexSh_Favorite.Range("A" & line).Cut
  LadexSh_Favorite.Range("A" & endLine).Insert Shift:=xlDown
  
  Call RefreshListBox
End Function


'==================================================================================================
Function delete()
  Dim line As Long
  Dim filePath As String
  
  Call init.setting
  line = Frm_Favorite.Lst_Favorite.ListIndex + 2
  
  LadexSh_Favorite.Rows(line & ":" & line).delete Shift:=xlUp
  
  Call RefreshListBox
End Function









