Attribute VB_Name = "Ctl_Cells"
'**************************************************************************************************
' * セル編集
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Option Explicit

'**************************************************************************************************
' * 文字列操作
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function Trim01()
  
  Call init.setting
  ActiveCell = Trim(ActiveCell.Text)
  
  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:

End Function

'==================================================================================================
Function 中黒点付与()
  Dim line As Long, endLine As Long
  Dim slctCells As Range
  Dim Reg As Object
  
  Set Reg = CreateObject("VBScript.RegExp")
  With Reg
    .Pattern = "^・"
    .IgnoreCase = False
    .Global = True
  End With
  
  '処理開始--------------------------------------
  'On Error GoTo catchError
  funcName = "Ctl_Cells.中黒点付与"

  Call Library.startScript
  Call init.setting
  '----------------------------------------------
  For Each slctCells In Selection
    'Call Library.showDebugForm("選択セル値：" & Reg.Replace(slctCells.Value, ""))
    slctCells.Value = "・" & Reg.Replace(slctCells.Value, "")
    
    DoEvents
  Next

  '処理終了--------------------------------------
  Call Library.endScript
  '----------------------------------------------

  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:
  Call Library.showNotice(400, funcName & vbNewLine & Err.Number & "：" & Err.Description, True)
End Function


'==================================================================================================
Function 連番設定()
  Dim line As Long, endLine As Long
  Dim slctCells As Range
  
  
  '処理開始--------------------------------------
  'On Error GoTo catchError
  funcName = "Ctl_Cells.連番設定"

  Call Library.startScript
  Call init.setting
  '----------------------------------------------
  line = 1
  For Each slctCells In Selection
    'slctCells.NumberFormatLocal = "@"
    slctCells.Value = line
    line = line + 1
    DoEvents
  Next

  '処理終了--------------------------------------
  Call Library.endScript
  '----------------------------------------------

  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:
  Call Library.showNotice(400, funcName & vbNewLine & Err.Number & "：" & Err.Description, True)
End Function



'==================================================================================================
Function 連番追加()
  Dim line As Long, endLine As Long
  Dim slctCells As Range
  Dim Reg As Object
  
  Set Reg = CreateObject("VBScript.RegExp")
  With Reg
    .Pattern = "^[0-9]+．"
    .IgnoreCase = False
    .Global = True
  End With
  
  '処理開始--------------------------------------
  'On Error GoTo catchError
  funcName = "Ctl_Cells.連番追加"

  Call Library.startScript
  Call init.setting
  '----------------------------------------------
  line = 1
  For Each slctCells In Selection
'    Call Library.showDebugForm("選択セル値：" & Reg.Replace(slctCells.Value, ""))
    slctCells.Value = line & "．" & Reg.Replace(slctCells.Value, "")
    line = line + 1
    DoEvents
  Next

  '処理終了--------------------------------------
  Call Library.endScript
  '----------------------------------------------

  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:
  Call Library.showNotice(400, funcName & vbNewLine & Err.Number & "：" & Err.Description, True)
End Function



'==================================================================================================
Function 英数字全半角変換()
  Dim line As Long, endLine As Long
  Dim slctCells As Range
  
  
  '処理開始--------------------------------------
  'On Error GoTo catchError
  funcName = "Ctl_Cells.英数字全半角変換"

  Call Library.startScript
  Call init.setting
  '----------------------------------------------
  For Each slctCells In Selection
    slctCells.Value = Library.convHan2Zen(slctCells.Value)
    DoEvents
  Next

  '処理終了--------------------------------------
  Call Library.endScript
  '----------------------------------------------

  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:
  Call Library.showNotice(400, funcName & vbNewLine & Err.Number & "：" & Err.Description, True)
End Function


'==================================================================================================
Function 取り消し線設定()
  Dim line As Long, endLine As Long
  Dim slctCells As Range
  
  
  '処理開始--------------------------------------
  'On Error GoTo catchError
  funcName = "Ctl_Cells.取り消し線設定"

  Call Library.startScript
  Call init.setting
  '----------------------------------------------
  For Each slctCells In Selection
    If slctCells.Font.Strikethrough = True Then
      slctCells.Font.Strikethrough = False
    Else
      slctCells.Font.Strikethrough = True
    End If
    DoEvents
  Next

  '処理終了--------------------------------------
  Call Library.endScript
  '----------------------------------------------

  Exit Function
'エラー発生時--------------------------------------------------------------------------------------
catchError:
  Call Library.showNotice(400, funcName & vbNewLine & Err.Number & "：" & Err.Description, True)
End Function

'==================================================================================================
Function コメント挿入()
  Dim commentVal As String
  Const funcName As String = "Ctl_Cells.コメント挿入"

  '処理開始--------------------------------------
  On Error GoTo catchError
  Call init.setting
  Call Library.showDebugForm("" & funcName, , "function")
  '----------------------------------------------
  commentVal = ""
  If TypeName(ActiveCell.Comment) = "Comment" Then
    commentVal = ActiveCell.Comment.Text
  End If
  With Frm_InsComment
    .TextBox = commentVal
    .Label1.Caption = "選択セル：" & ActiveCell.Address(RowAbsolute:=False, ColumnAbsolute:=False)
    .Show
  End With
  
  '処理終了--------------------------------------
  Call Library.showDebugForm("  ", , "end")
  '----------------------------------------------

  Exit Function
'エラー発生時------------------------------------
catchError:
  Call Library.showNotice(400, "<" & funcName & " [" & Err.Number & "]" & Err.Description & ">", True)
End Function

'==================================================================================================
Function コメント削除()
  Const funcName As String = "Ctl_Cells.コメント削除"

  '処理開始--------------------------------------
  On Error GoTo catchError
  Call init.setting
  Call Library.showDebugForm("" & funcName, , "function")
  '----------------------------------------------
  
  If TypeName(ActiveCell.Comment) = "Comment" Then
    ActiveCell.ClearComments
  End If
  
  '処理終了--------------------------------------
  Call Library.showDebugForm("  ", , "end")
  '----------------------------------------------

  Exit Function
'エラー発生時------------------------------------
catchError:
  Call Library.showNotice(400, "<" & funcName & " [" & Err.Number & "]" & Err.Description & ">", True)
End Function


