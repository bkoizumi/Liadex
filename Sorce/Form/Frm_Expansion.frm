VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} Frm_Expansion 
   Caption         =   "�g��"
   ClientHeight    =   6795
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   10335
   OleObjectBlob   =   "Frm_Expansion.frx":0000
   StartUpPosition =   2  '��ʂ̒���
End
Attribute VB_Name = "Frm_Expansion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub CancelButton_Click()
  Call Library.setRegistry("UserForm", "ZoomInTop", Me.Top)
  Call Library.setRegistry("UserForm", "ZoomInLeft", Me.Left)


  Unload Frm_Expansion
End Sub

Private Sub OK_Button_Click()
  Call Library.setRegistry("UserForm", "ZoomInTop", Me.Top)
  Call Library.setRegistry("UserForm", "ZoomInLeft", Me.Left)
  
  
  Call Library.showExpansionFormClose(TextBox, Frm_Expansion.Caption)
  Unload Frm_Expansion
End Sub
