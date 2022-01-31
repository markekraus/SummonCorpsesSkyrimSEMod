Scriptname MEKSCSSummonCorpsesScript extends ObjectReference  

ActorBase Property MEKSCSSummonedCorpse Auto
Static Property MEKSCSNordicCoffinStatic04 Auto
EffectShader Property DA02ArmorShadow Auto

float dropHeight = 100.0
float spawnDelay = 0.1
float coffinOffset = 155.0
float coffinDespawnDelay = 0.5

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
    DA02ArmorShadow.Play(coffiinRef, -1)
    coffiinRef.MoveTo(self, 0.0, 0.0, dropHeight + coffinOffset)
    coffiinRef.SetAngle(0, 180, 0)
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
    float playerConjurationLevel = Game.GetPlayer().GetActorValue("Conjuration")
    If (playerConjurationLevel < 20)
        return 1
    EndIf
    If (playerConjurationLevel < 30)
        return 5
    EndIf
    If (playerConjurationLevel < 40)
        return 10
    EndIf
    If (playerConjurationLevel < 50)
        return 15
    EndIf
    If (playerConjurationLevel < 60)
        return 20
    EndIf
    return 25
EndFunction