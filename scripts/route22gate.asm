Route22GateScript: ; 1e683 (7:6683)
	call EnableAutoTextBoxDrawing
	ld hl, Route22GateScriptPointers
	ld a, [wRoute22GateCurScript]
	call CallFunctionInTable
	ld a, [wYCoord]
	cp $4
	ld a, ROUTE_23
	jr c, .asm_1e69a
	ld a, ROUTE_22
.asm_1e69a
	ld [wLastMap], a
	ret

Route22GateScriptPointers: ; 1e69e (7:669e)
	dw Route22GateScript0
	dw Route22GateScript1
	dw Route22GateScript2

Route22GateScript0: ; 1e6a4 (7:66a4)
	ld hl, Route22GateScriptCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ld [hJoyHeld], a
	ld a, $1
	ld [hSpriteIndexOrTextID], a
	jp DisplayTextID

Route22GateScriptCoords: ; 1e6b5 (7:66b5)
	db 2,4
	db 2,5
	db $ff

Route22GateScript_1e6ba: ; 1e6ba (7:66ba)
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSpriteStateData1 + 9], a
	ld [wJoyIgnore], a
	jp StartSimulatingJoypadStates

Route22GateScript1: ; 1e6cd (7:66cd)
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	call Delay3
	ld a, $0
	ld [wRoute22GateCurScript], a
Route22GateScript2: ; 1e6de (7:66de)
	ret

Route22GateTextPointers: ; 1e6df (7:66df)
	dw Route22GateText1

Route22GateText1: ; 1e6e1 (7:66e1)
	TX_ASM
	ld a, [wObtainedBadges]
	bit 0, a
	jr nz, .asm_1e6f6
	ld hl, Route22GateText_1e704
	call PrintText
	call Route22GateScript_1e6ba
	ld a, $1
	jr .asm_1e6fe
.asm_1e6f6
	ld hl, Route22GateText_1e71a
	call PrintText
	ld a, $2
.asm_1e6fe
	ld [wRoute22GateCurScript], a
	jp TextScriptEnd

Route22GateText_1e704: ; 1e704 (7:6704)
	TX_FAR _Route22GateText_1e704
	TX_ASM
	ld a, SFX_DENIED
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld hl, Route22GateText_1e715
	ret

Route22GateText_1e715: ; 1e715 (7:6715)
	TX_FAR _Route22GateText_1e715
	db "@"

Route22GateText_1e71a: ; 1e71a (7:671a)
	TX_FAR _Route22GateText_1e71a
	db $0B, "@"
