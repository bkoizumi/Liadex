Attribute VB_Name = "Ctl_SaveVal"
Option Explicit

'**************************************************************************************************
' * VBA���s�O�̒l��ێ�
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function setVal(pType As String, pText As String)
  Dim line As Long, endLine As Long
  Dim chkFlg As Boolean
  Const funcName As String = "Ctl_SaveVal.setVal"
  
  '�����J�n--------------------------------------
  If runFlg = False Then
    Call init.setting
    Call Library.showDebugForm(funcName, , "start")
    Call Library.startScript
    Call Ctl_ProgressBar.showStart
    PrgP_Max = 4
  Else
    Call Library.showDebugForm(funcName, , "start1")
  End If
  Call Library.showDebugForm("runFlg", runFlg, "debug")
  '----------------------------------------------
  chkFlg = False
  BK_ThisBook.Activate
  
  endLine = Cells(Rows.count, 4).End(xlUp).Row
  For line = 3 To BK_sheetSetting.Cells(Rows.count, 4).End(xlUp).Row
    If BK_sheetSetting.Range(BK_setVal("Cells_pType") & line) = pType Then
      BK_sheetSetting.Range(BK_setVal("Cells_pType") & line) = pType
      BK_sheetSetting.Range(BK_setVal("Cells_pText") & line) = pText
      
      chkFlg = True
      Exit For
    End If
  Next
   
  If chkFlg = False Then
    BK_sheetSetting.Range(BK_setVal("Cells_pType") & line) = pType
    BK_sheetSetting.Range(BK_setVal("Cells_pText") & line) = pText
  End If
  
  '�����I��--------------------------------------
  If runFlg = False Then
    Call Ctl_ProgressBar.showEnd
    Call Library.endScript
    Call Library.showDebugForm("", , "end")
    Call init.unsetting
  Else
    Call Library.showDebugForm("", , "end1")
  End If
  '----------------------------------------------
End Function


'==================================================================================================
Function getVal(pType As String) As String
  Dim resetObjVal          As Object
  Dim line As Long, endLine As Long
  Const funcName As String = "Ctl_SaveVal.getVal"
  
  '�����J�n--------------------------------------
  If runFlg = False Then
    Call init.setting
    Call Library.showDebugForm(funcName, , "start")
    Call Library.startScript
    Call Ctl_ProgressBar.showStart
    PrgP_Max = 4
  Else
    Call Library.showDebugForm(funcName, , "start1")
  End If
  Call Library.showDebugForm("runFlg", runFlg, "debug")
  '----------------------------------------------
  
  Set resetObjVal = Nothing
  Set resetObjVal = CreateObject("Scripting.Dictionary")
  
  For line = 3 To BK_sheetSetting.Cells(Rows.count, 4).End(xlUp).Row
    If BK_sheetSetting.Range(BK_setVal("Cells_pType") & line) <> "" Then
      resetObjVal.add BK_sheetSetting.Range(BK_setVal("Cells_pType") & line).Text, BK_sheetSetting.Range(BK_setVal("Cells_pText") & line).Text
    End If
  Next
  
  If resetObjVal("reSet" & pType) = "" Then
    getVal = resetObjVal(pType)
  Else
    getVal = resetObjVal("reSet" & pType)
  End If
  Set resetObjVal = Nothing
  
  '�����I��--------------------------------------
  If runFlg = False Then
    Call Ctl_ProgressBar.showEnd
    Call Library.endScript
    Call Library.showDebugForm("", , "end")
    Call init.unsetting
  Else
    Call Library.showDebugForm("", , "end1")
  End If
  '----------------------------------------------
End Function

'==================================================================================================
Function delVal(pType As String)
  Dim line As Long, endLine As Long
  Const funcName As String = "Ctl_SaveVal.delVal"
  
  '�����J�n--------------------------------------
  If runFlg = False Then
    Call init.setting
    Call Library.showDebugForm(funcName, , "start")
    Call Library.startScript
    Call Ctl_ProgressBar.showStart
    PrgP_Max = 4
  Else
    Call Library.showDebugForm(funcName, , "start1")
  End If
  Call Library.showDebugForm("runFlg", runFlg, "debug")
  '----------------------------------------------
  
  For line = 3 To BK_sheetSetting.Cells(Rows.count, 4).End(xlUp).Row
    If BK_sheetSetting.Range(BK_setVal("Cells_pType") & line) Like "*" & pType Then
      BK_sheetSetting.Range(BK_setVal("Cells_pType") & line) = ""
      BK_sheetSetting.Range(BK_setVal("Cells_pText") & line) = ""
    End If
  Next
 
  '�����I��--------------------------------------
  If runFlg = False Then
    Call Ctl_ProgressBar.showEnd
    Call Library.endScript
    Call Library.showDebugForm("", , "end")
    Call init.unsetting
  Else
    Call Library.showDebugForm("", , "end1")
  End If
  '----------------------------------------------
End Function
