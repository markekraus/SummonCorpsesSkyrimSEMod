Scriptname MEKSCSSummonCorpsesScript extends ObjectReference  

ActorBase Property MEKSCSSummonedCorpse Auto
Static Property MEKSCSNordicCoffinStatic04 Auto
EffectShader Property DA02ArmorShadow Auto
GlobalVariable Property MEKSCSMaxSummonedCorpseSetting Auto

float dropHeight = 100.0
float spawnDelay = 0.1
float coffinOffset = 155.0
float coffinDespawnDelay = 1.0

Event OnLoad()
    SummonCorpses(GetCorpseCount())
    RegisterForSingleUpdate(5.0)
EndEvent

Event OnUpdate()
    Disable()
    Delete()
endEvent

Event OnUnload()
EndEvent

Function SummonCorpses(int corpseCount)
    ObjectReference coffiinRef = self.PlaceAtMe(MEKSCSNordicCoffinStatic04)
    coffiinRef.MoveTo(self, 0.0, 0.0, dropHeight + coffinOffset)
    coffiinRef.SetAngle(0, 180, 0)
    DA02ArmorShadow.Play(coffiinRef, -1)
    Utility.Wait(spawnDelay)
    int index = 0
    While (index < corpseCount)
        ObjectReference currentCorpse = self.PlaceAtMe(MEKSCSSummonedCorpse)
        currentCorpse.MoveTo(self, 0.0, 0.0, dropHeight)
        (currentCorpse as Actor).Kill()
        index += 1
        Utility.Wait(spawnDelay)
    EndWhile
    Utility.Wait(coffinDespawnDelay)
    DA02ArmorShadow.Stop(coffiinRef)
    coffiinRef.Disable()
    coffiinRef.Delete()
EndFunction

int Function GetCorpseCount()
    int [] distribution = GetDistribution()

    float playerConjurationLevel = Game.GetPlayer().GetActorValue("Conjuration")

    If (playerConjurationLevel < 20)
        return distribution[0]
    EndIf
    If (playerConjurationLevel < 30)
        return distribution[1]
    EndIf
    If (playerConjurationLevel < 40)
        return distribution[2]
    EndIf
    If (playerConjurationLevel < 50)
        return distribution[3]
    EndIf
    If (playerConjurationLevel < 60)
        return distribution[4]
    EndIf
    return distribution[5]
EndFunction

int[] Function GetDistribution()
    int maxCorpsesSetting = MEKSCSMaxSummonedCorpseSetting.GetValue() as int
    If (maxCorpsesSetting > 5)
        maxCorpsesSetting = 5
    EndIf
    If (maxCorpsesSetting < 0)
        maxCorpsesSetting = 0
    EndIf

    int[] distribution = new int[6]
    If (maxCorpsesSetting == 0)
        distribution[0] = 1
        distribution[1] = 1
        distribution[2] = 1
        distribution[3] = 1
        distribution[4] = 1
        distribution[5] = 1
        return distribution
    EndIf
    If (maxCorpsesSetting == 1)
        distribution[0] = 1
        distribution[1] = 1
        distribution[2] = 2
        distribution[3] = 3
        distribution[4] = 4
        distribution[5] = 5
        return distribution
    EndIf
    If (maxCorpsesSetting == 2)
        distribution[0] = 1
        distribution[1] = 2
        distribution[2] = 4
        distribution[3] = 6
        distribution[4] = 8
        distribution[5] = 10
        return distribution
    EndIf
    If (maxCorpsesSetting == 3)
        distribution[0] = 1
        distribution[1] = 3
        distribution[2] = 5
        distribution[3] = 7
        distribution[4] = 10
        distribution[5] = 15
        return distribution
    EndIf
    If (maxCorpsesSetting == 4)
        distribution[0] = 1
        distribution[1] = 5
        distribution[2] = 8
        distribution[3] = 10
        distribution[4] = 15
        distribution[5] = 20
        return distribution
    EndIf
    If (maxCorpsesSetting == 5)
        distribution[0] = 1
        distribution[1] = 5
        distribution[2] = 10
        distribution[3] = 15
        distribution[4] = 10
        distribution[5] = 25
        return distribution
    EndIf
EndFunction