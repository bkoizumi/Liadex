Attribute VB_Name = "Ctl_Zoom"
Option Explicit

'**************************************************************************************************
' * 選択セルの拡大表示/終了
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function ZoomIn(Optional slctCellAddress As String)
  Dim cellVal As String
  Dim topPosition As Long, leftPosition As Long
  Dim cellWidth As Long
  
  If slctCellAddress = "" Then
    
  End If
  topPosition = Library.getRegistry("UserForm", "ZoomTop")
  leftPosition = Library.getRegistry("UserForm", "ZoomLeft")
  
  If ActiveCell.HasFormula = False Then
    cellVal = ActiveCell.Text
  Else
    cellVal = ActiveCell.Formula
  End If
  
  Call Ctl_UsrForm.表示位置(topPosition, leftPosition)
  
  cellWidth = ActiveCell.Width
  If cellWidth <= 280 Then
    cellWidth = 280
  ElseIf cellWidth >= 400 Then
    cellWidth = 400
  End If
  
  With Frm_Zoom
    .StartUpPosition = 0
    .Top = topPosition
    .Left = leftPosition
    .Width = cellWidth + 100
    
    .TextBox.Width = cellWidth + 50
    .TextBox = cellVal
    .TextBox.MultiLine = True
    .TextBox.MultiLine = True
    .TextBox.EnterKeyBehavior = True
    
    If cellVal = StrConv(cellVal, vbNarrow) Then
      '半角の場合
      .TextBox.IMEMode = fmIMEModeOff
    Else
      '全角の場合
      .TextBox.IMEMode = fmIMEModeOn
    End If
    
    
    .Label1.Caption = "選択セル：" & ActiveCell.Address(RowAbsolute:=False, ColumnAbsolute:=False)

    .Show vbModeless
  End With
End Function


'==================================================================================================
Function ZoomOut(Text As String, SetTargetAddress As String)
  
  SetTargetAddress = Replace(SetTargetAddress, "選択セル：", "")
  
  Range(SetTargetAddress).Value = Text
  Call endScript
End Function


'==================================================================================================
'全画面表示
Function Zoom01()
  Dim topPosition As Long, leftPosition As Long
  
  Application.DisplayFullScreen = True
  
  topPosition = Library.getRegistry("UserForm", "Zoom01Top")
  leftPosition = Library.getRegistry("UserForm", "Zoom01Left")

  Call Ctl_UsrForm.表示位置(topPosition, leftPosition)
  With Frm_DispFullScreenForm
    .StartUpPosition = 0
    .Top = topPosition
    .Left = leftPosition
    .Show vbModeless
  End With
  
End Function

