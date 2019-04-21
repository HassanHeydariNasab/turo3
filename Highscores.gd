
extends Control

const SERVER = 'https://nishe.ir/poento'
const SKU = 'item_test'
var is_cafebazaar_installed = false

var skip = 0
const LIMIT = 6

onready var ScoreList_index = $ScoreList_index
onready var ScoreList_name = $ScoreList_name
onready var ScoreList_value = $ScoreList_value

func _ready():
	iap.set_auto_consume(false)
	iap.connect("purchase_success", self, "on_purchase_success")
	iap.connect("purchase_fail", self, "on_purchase_fail")
	iap.connect("purchase_cancel", self, "on_purchase_cancel")
	iap.connect("purchase_owned", self, "on_purchase_owned")
	iap.connect("has_purchased", self, "on_has_purchased")
	iap.connect("consume_success", self, "on_consume_success")
	iap.connect("consume_fail", self, "on_consume_fail")
	iap.connect("sku_details_complete", self, "on_sku_details_complete")
	$Form/Record.set_text(
		str(G.Settings.get_value("Record", "record","0"))+"m"
	)
	fetch()
	if OS.get_name() == 'Android':
		var test_cafebazaar = OS.shell_open('bazaar://login')
		if test_cafebazaar == OK:
			is_cafebazaar_installed = true
		else:
			is_cafebazaar_installed = false
	if G.Settings.get_value('Record', 'is_submitted', false):
		Form.hide()
		Result_already_submitted.show()
	else:
		Form.show()
		Result_already_submitted.hide()



func on_purchase_success(item_name):
	# alert.set_text("Purchase success : " + item_name)
	# alert.popup()
	print('purchase successed')
	submit()

func on_purchase_fail():
	# alert.set_text("Purchase fail")
	# alert.popup()
	print('purchase failed')

func on_purchase_cancel():
	# alert.set_text("Purchase cancel")
	# alert.popup()
	print('purchase canceled')

func on_purchase_owned(item_name):
	# alert.set_text("Purchase owned : " + item_name)
	# alert.popup()
	print('owned')

func on_has_purchased(item_name):
	if item_name == null:
		# alert.set_text("Don't have purchased item")
		print('nothing')
		iap.purchase(SKU)
	else:
		# alert.set_text("Has purchased : " + item_name)
		if SKU in item_name:
			submit()
		else:
			print('not found')
			iap.purchase(SKU)

func on_consume_success(item_name):
	print("Consume success : " + item_name)
#	pass

func on_consume_fail():
	print("Try to request purchased first")
#	pass

func on_sku_details_complete():
	# alert.set_text("Got detail info : " + to_json(iap.sku_details[SKU]))
	# alert.popup()
	print(to_json(iap.sku_details[SKU]))

func _on_Submit_pressed():
	if OS.get_name() == 'Android' and is_cafebazaar_installed:
#	if OS.get_name() == 'Android':
		print('request')
		iap.request_purchased()
	else:
		print('else')
		submit()

# for debug only
func _on_Consume_pressed():
	if OS.get_name() == 'Android' and is_cafebazaar_installed:
		iap.consume(SKU)

# func button_purchase():
# 	iap.purchase(SKU)

# func button_consume():
# 	iap.consume(SKU)

# func button_request():
# 	iap.request_purchased()

# func button_query():
# 	iap.sku_details_query([SKU, "item_test_b"])


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
	fetch()


func _on_Previous_pressed():
	skip -= LIMIT
	if skip < 0:
		skip = 0
	fetch()
