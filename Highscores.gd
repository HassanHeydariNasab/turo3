
extends Control

const SERVER = 'https://nishe.ir/poento'

var skip = 0
const LIMIT = 6

onready var ScoreList_index = $ScoreList_index
onready var ScoreList_name = $ScoreList_name
onready var ScoreList_value = $ScoreList_value

onready var Next = $Next
onready var Previous = $Previous


func _ready():
	$Form/Record.set_text(
		str(G.Settings.get_value("Record", "record","0"))+"m"
	)
	fetch()
	if G.Settings.get_value('Record', 'is_submitted', false):
		Form.hide()
		Result_already_submitted.show()
	else:
		Form.show()
		Result_already_submitted.hide()


func _on_Submit_pressed():
	submit()


func submit():
	var headers = ['Content-Type: application/json']
	var query = JSON.print({'country': 'IR', 'name': $Form/Name.get_text(), 'value': G.Settings.get_value("Record", "record", 0)})
	$HTTPRequest_Submit.request(SERVER+'/v1/scores', headers, false, HTTPClient.METHOD_POST, query)


func fetch():
	$HTTPRequest_Fetch.request(
		SERVER+'/v1/scores?skip='+str(skip)+'&limit='+str(LIMIT),
		[], false, HTTPClient.METHOD_GET
	)


onready var Result_already_submitted = $Result_already_submitted
onready var Form = $Form
func _on_HTTPRequest_Submit_request_completed( result, response_code, headers, body ):
	print(response_code)
	if response_code == 201:
#		var json = JSON.parse(body.get_string_from_utf8())
		fetch()
		Result_already_submitted.show()
		Form.hide()
		G.Settings.set_value('Record', 'is_submitted', true)
		G.Settings.save(G.settings_file)
	else:
		pass


func _on_HTTPRequest_Fetch_request_completed(result, response_code, headers, body):
	print(response_code)
	if response_code == 200:
		var json = JSON.parse(body.get_string_from_utf8())
		var scores = json.result['scores']
		ScoreList_index.clear()
		ScoreList_name.clear()
		ScoreList_value.clear()
		for score_index in range(0, len(scores)):
			ScoreList_index.add_item(str(skip+score_index+1), null, false)
			ScoreList_name.add_item(scores[score_index]['name'], null, false)
			ScoreList_value.add_item(str(scores[score_index]['value'])+'m', null, false)
	elif response_code == 0:
		pass
	else:
		pass


func _on_Back_pressed():
	get_tree().change_scene("res://Menu.tscn")


func _on_Next_pressed():
	skip += LIMIT
	Previous.show()
	fetch()


func _on_Previous_pressed():
	skip -= LIMIT
	if skip < 0:
		skip = 0
	fetch()
