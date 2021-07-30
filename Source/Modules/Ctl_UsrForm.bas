Attribute VB_Name = "Ctl_UsrForm"
'**************************************************************************************************
' * 表示位置確認
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function 表示位置(t, l)
  Dim topPosition As Long, leftPosition As Long
  
  topPosition = CLng(t)
  leftPosition = CLng(l)
  
  Call Library.getMachineInfo
  
'  Call Library.showDebugForm("topPosition ：" & topPosition)
'  Call Library.showDebugForm("leftPosition：" & leftPosition)
'
'  Call Library.showDebugForm("displayX    ：" & MachineInfo("displayX"))
'  Call Library.showDebugForm("displayY    ：" & MachineInfo("displayY"))
  
  If topPosition > MachineInfo("displayX") Then
    t = CInt(MachineInfo("displayX") / 4)
  ElseIf topPosition = 0 Then
    t = CInt(MachineInfo("displayX") / 4)
  End If
  
  If leftPosition > MachineInfo("displayY") Then
    l = CInt(MachineInfo("displayY") / 4)
  ElseIf leftPosition = 0 Then
    l = CInt(MachineInfo("displayY") / 4)
  End If
  
'  Call Library.showDebugForm("t：" & t)
'  Call Library.showDebugForm("l：" & l)

End Function



'**************************************************************************************************
' * イベント処理
' *
' * @author Bunpei.Koizumi<bunpei.koizumi@gmail.com>
'**************************************************************************************************
'==================================================================================================
Function 日付(inputVal As Variant)

'  Call Library.showDebugForm("inputVal：" & inputVal)
  
  If IsDate(inputVal) Then
    inputVal = Format(inputVal, "yyyy/mm/dd")
  ElseIf inputVal = "" Then
    inputVal = ""
  Else
    inputVal = False
  End If
  
  日付 = inputVal
  
End Function

