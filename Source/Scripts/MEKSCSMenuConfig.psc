Scriptname MEKSCSMenuConfig extends SKI_ConfigBase

GlobalVariable Property MEKSCSMaxSummonedCorpseSetting Auto

int maxCorpsesMenuOID
string[] maxCorpsesOptions
string PageTitle01 = "Settings"
int curMaxCorpsesOption = 5

int function GetVersion()
    return 1
endFunction

event OnConfigInit()
    {Called when this config menu is initialized}
    ;Pages = new String[1]
    ;Pages[0] = PageTitle01
    
    int globalSetting = MEKSCSMaxSummonedCorpseSetting.GetValue() as int
    If (globalSetting > 5)
        globalSetting = 5
    EndIf
    If (globalSetting < 0)
        globalSetting = 0
    EndIf
    curMaxCorpsesOption = globalSetting

    maxCorpsesOptions = new String[6]
    maxCorpsesOptions[0] = "1"
    maxCorpsesOptions[1] = "5"
    maxCorpsesOptions[2] = "10"
    maxCorpsesOptions[3] = "15"
    maxCorpsesOptions[4] = "20"
    maxCorpsesOptions[5] = "25"
endEvent

event OnPageReset(string a_page)
    {Called when a new page is selected, including the initial empty page}

    If (a_page == "")
        SetCursorFillMode(TOP_TO_BOTTOM)
        maxCorpsesMenuOID = AddMenuOption("Max Summoned Corpses", maxCorpsesOptions[curMaxCorpsesOption])
    EndIf
endEvent

event OnOptionHighlight(int a_option)
    {Called when highlighting an option}

    if (a_option == maxCorpsesMenuOID)
        SetInfoText("Sets the maximum corpses suommoned and changes the scaling with the Conjuration skill.")
    EndIf
endEvent

event OnOptionMenuOpen(int a_option)
    {Called when a menu option has been selected}

    if (a_option == maxCorpsesMenuOID)
        SetMenuDialogStartIndex(curMaxCorpsesOption)
        SetMenuDialogDefaultIndex(5)
        SetMenuDialogOptions(maxCorpsesOptions)
    endIf
endEvent

event OnOptionMenuAccept(int a_option, int a_index)
    {Called when a menu entry has been accepted}

    if (a_option == maxCorpsesMenuOID)
        curMaxCorpsesOption = a_index
        MEKSCSMaxSummonedCorpseSetting.SetValue(a_index)
        SetMenuOptionValue(a_option, maxCorpsesOptions[curMaxCorpsesOption])
    EndIf
endEvent

; Not Implimented:

event OnVersionUpdate(int a_version)
    {Called when a version update of this script has been detected}
endEvent

event OnOptionSelect(int a_option)
    {Called when a non-interactive option has been selected}
endEvent

event OnOptionDefault(int a_option)
    {Called when resetting an option to its default value}
endEvent

event OnOptionSliderOpen(int a_option)
    {Called when a slider option has been selected}
endEvent

event OnOptionSliderAccept(int a_option, float a_value)
    {Called when a new slider value has been accepted}
endEvent

event OnOptionColorOpen(int a_option)
    {Called when a color option has been selected}
endEvent

event OnOptionColorAccept(int a_option, int a_color)
    {Called when a new color has been accepted}
endEvent

event OnOptionKeyMapChange(int a_option, int a_keyCode, string a_conflictControl, string a_conflictName)
    {Called when a key has been remapped}
endEvent

event OnOptionInputOpen(int a_option)
    {Called when a text input option has been selected}
endEvent

event OnOptionInputAccept(int a_option, string a_input)
    {Called when a new text input has been accepted}
endEvent
