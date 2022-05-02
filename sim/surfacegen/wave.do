onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Game Screen} /tb_surfacegen/Ceiling
add wave -noupdate -expand -group {Game Screen} /tb_surfacegen/Floor
add wave -noupdate -expand -group Tick /tb_surfacegen/TransitionTick
add wave -noupdate -expand -group Tick /tb_surfacegen/MoveTick
add wave -noupdate /tb_surfacegen/Rst
add wave -noupdate -radix unsigned -childformat {{{/tb_surfacegen/TransitionDiff[3]} -radix unsigned} {{/tb_surfacegen/TransitionDiff[2]} -radix unsigned} {{/tb_surfacegen/TransitionDiff[1]} -radix unsigned} {{/tb_surfacegen/TransitionDiff[0]} -radix unsigned}} -subitemconfig {{/tb_surfacegen/TransitionDiff[3]} {-radix unsigned} {/tb_surfacegen/TransitionDiff[2]} {-radix unsigned} {/tb_surfacegen/TransitionDiff[1]} {-radix unsigned} {/tb_surfacegen/TransitionDiff[0]} {-radix unsigned}} /tb_surfacegen/TransitionDiff
add wave -noupdate /tb_surfacegen/DUT_SR/TransitionTick
add wave -noupdate /tb_surfacegen/DUT_SR/MoveTick
add wave -noupdate /tb_surfacegen/DUT_SR/Rst
add wave -noupdate -radix unsigned /tb_surfacegen/DUT_SR/TransitionDiff
add wave -noupdate /tb_surfacegen/DUT_SR/Ceiling
add wave -noupdate /tb_surfacegen/DUT_SR/Floor
add wave -noupdate /tb_surfacegen/DUT_SR/FloorIn
add wave -noupdate /tb_surfacegen/DUT_SR/CeilIn
add wave -noupdate /tb_surfacegen/DUT_SR/SRRst
add wave -noupdate /tb_surfacegen/DUT_SR/CeilRstVal
add wave -noupdate /tb_surfacegen/DUT_SR/FloorRstVal
add wave -noupdate /tb_surfacegen/DUT_SR/State
add wave -noupdate /tb_surfacegen/DUT_SR/Count
add wave -noupdate /tb_surfacegen/DUT_SR/LastPos
add wave -noupdate /tb_surfacegen/DUT_SR/FloorSR/BitIn
add wave -noupdate /tb_surfacegen/DUT_SR/FloorSR/Shift
add wave -noupdate /tb_surfacegen/DUT_SR/FloorSR/Rst
add wave -noupdate /tb_surfacegen/DUT_SR/FloorSR/RstValue
add wave -noupdate /tb_surfacegen/DUT_SR/FloorSR/RegContent
add wave -noupdate /tb_surfacegen/DUT_SR/CeilSR/BitIn
add wave -noupdate /tb_surfacegen/DUT_SR/CeilSR/Shift
add wave -noupdate /tb_surfacegen/DUT_SR/CeilSR/Rst
add wave -noupdate /tb_surfacegen/DUT_SR/CeilSR/RstValue
add wave -noupdate /tb_surfacegen/DUT_SR/CeilSR/RegContent
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {109000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 270
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {169300 ps} {233200 ps}
