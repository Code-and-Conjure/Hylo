extends Node

@export var leadVariance: int = 5
@export var brushVariance: int = 5
@export var hatsVariance: int = 5

@onready var chords: AudioStreamPlayer = $Chords
@onready var ambient_brush: AudioStreamPlayer = $AmbientBrush
@onready var lead_1: AudioStreamPlayer = $Lead1
@onready var lead_2: AudioStreamPlayer = $Lead2
@onready var off_hats: AudioStreamPlayer = $OffHats

var prevTime: float = -1.0

var currLead: AudioStreamPlayer
var leadWait: int = 0
var brushWait: int = 0
var hatsWait: int = 0

func _ready():
	chords.stream.set_loop(true)
	leadWait = randi_range(0, leadVariance)
	brushWait = randi_range(0, brushVariance)
	hatsWait = randi_range(0, hatsVariance)

func _process(delta):
	var time = chords.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	if snapped(time, 1) < snapped(prevTime, 1):
		decrementAll()
		if leadWait == 0:
			if currLead and currLead.playing:
				currLead.stream.set_loop(false)
			else:
				leadWait = randi_range(0, leadVariance)
				if randi_range(0, 1) == 0:
					currLead = lead_1
				else:
					currLead = lead_2
				currLead.stream.set_loop(true)
				currLead.play(time)
		if brushWait == 0:
			if ambient_brush.playing:
				ambient_brush.stream.set_loop(false)
			else:
				brushWait = randi_range(0, brushVariance)
				ambient_brush.stream.set_loop(true)
				ambient_brush.play(time)
				
		if hatsWait == 0:
			if off_hats.playing:
				off_hats.stream.set_loop(false)
			else:
				hatsWait = randi_range(0, hatsVariance)
				off_hats.stream.set_loop(true)
				off_hats.play(time)
	prevTime = time

func decrementAll():
	leadWait = clamp(leadWait-1, 0, leadVariance)
	brushWait = clamp(brushWait-1, 0, brushVariance)
	hatsWait = clamp(hatsWait-1, 0, hatsVariance)
