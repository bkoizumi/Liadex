VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} Frm_InsComment 
   Caption         =   "コメント設定"
   ClientHeight    =   4830
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   7050
   OleObjectBlob   =   "Frm_InsComment.frx":0000
   StartUpPosition =   2  '画面の中央
End
Attribute VB_Name = "Frm_InsComment"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim ret As Boolean
Dim colorValue As Long
Dim HighLightDspDirection As String
Dim old_BKh_rbPressed  As Boolean
Public InitializeFlg   As Boolean





'**************************************************************************************************
' * 初期設定
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Private Sub UserForm_Initialize()
  Dim endLine As Long
  Dim indexCnt As Integer, i As Variant
  Dim cBox As CommandBarComboBox
  
  InitializeFlg = True
  
  Call init.setting
  Application.Cursor = xlDefault
  indexCnt = 0
  
  StartUpPosition = 0
  Top = ActiveWindow.Top + ((ActiveWindow.Height - Height) / 2)
  Left = ActiveWindow.Left + ((ActiveWindow.Width - Width) / 2)
    
  With Frm_InsComment
    'コメント 背景色-----------------------------
    CommentBgColor = Library.getRegistry("Main", "CommentBgColor")
    .CommentColor.BackColor = CommentBgColor
    .CommentColor.Caption = ""
    
    'コメント フォント---------------------------
    .CommentFontColor = Library.getRegistry("Main", "CommentFontColor")
    .CommentFontColor.BackColor = CommentFontColor
    .CommentFontColor.Caption = ""
    
    CommentFont = Library.getRegistry("Main", "CommentFont")
    Set cBox = Application.CommandBars("Formatting").Controls.Item(1)
    indexCnt = 0
    For i = 1 To cBox.ListCount
      .CommentFont.AddItem cBox.list(i)
      If cBox.list(i) = CommentFont Then
        ListIndex = indexCnt
      End If
      indexCnt = indexCnt + 1
    Next
    .CommentFont.ListIndex = ListIndex

    'コメント フォントサイズ---------------------
    indexCnt = 0
    CommentFontSize = Library.getRegistry("Main", "CommentFontSize")
    For Each i In Split("6,7,8,9,10,11,12,14,16,18,20", ",")
      .CommentFontSize.AddItem i
      If i = CommentFontSize Then
        ListIndex = indexCnt
      End If
      indexCnt = indexCnt + 1
    Next
    .CommentFont.ListIndex = ListIndex

  End With
  
  InitializeFlg = False
End Sub

'**************************************************************************************************
' * スタイル設定
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Private Sub IncludeFont01_Click()
  If IncludeFont01.Value = True Then
    ret = セルの書式設定_フォント(1)
    IncludeFont01.Value = ret
  End If
End Sub

'**************************************************************************************************
' * 組み込みダイアログ表示
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
Function セルの書式設定_フォント(Optional line As Long = 1)
  Call init.setting
  sheetStyle2.Select
  sheetStyle2.Cells(line + 1, 11).Select
  ret = Application.Dialogs(xlDialogActiveCellFont).Show
  If ret = True Then
    sheetStyle2.Cells(line + 1, 5) = "TRUE"
  Else
    sheetStyle2.Cells(line + 1, 5) = "FALSE"
  End If
  セルの書式設定_フォント = ret
End Function


'**************************************************************************************************
' * ボタン押下時処理
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Private Sub CommentColor_Click()
  colorValue = Library.getColor(CommentColor.BackColor)
  CommentColor.BackColor = colorValue
  CommentColor.Caption = ""
  
End Sub

'==================================================================================================
Private Sub CommentFontColor_Click()
  colorValue = Library.getColor(CommentFontColor.BackColor)
  CommentFontColor.BackColor = colorValue
  CommentFontColor.Caption = ""
End Sub

'==================================================================================================
Private Sub CommentFont_Change()
  CommentFontColor.Caption = ""
End Sub

'==================================================================================================
Private Sub CommentFontSize_Change()
  CommentFontColor.Caption = ""
End Sub

'==================================================================================================
'キャンセル処理
Private Sub CancelButton_Click()
  Unload Me
End Sub
'==================================================================================================
' 実行
Private Sub OK_Button_Click()
  Dim execDay As Date
  
  'コメント----------------------------------------------------------------------------------------
'  Call Library.setRegistry("Main", "CommentBgColor", CommentColor.BackColor)
'  Call Library.setRegistry("Main", "CommentFont", CommentFont.Value)
'
'  Call Library.setRegistry("Main", "CommentFontColor", CommentFontColor.BackColor)
'  Call Library.setRegistry("Main", "CommentFontSize", CommentFontSize.Value)

  If TextBox.Value <> "" Then
    If TypeName(ActiveCell.Comment) = "Comment" Then
      ActiveCell.ClearComments
    End If
    ActiveCell.AddComment TextBox.Value
    Call Library.setComment(CommentColor.BackColor, CommentFont.Value, CommentFontColor.BackColor, CommentFontSize.Value)
  End If
  
  Unload Me
End Sub


