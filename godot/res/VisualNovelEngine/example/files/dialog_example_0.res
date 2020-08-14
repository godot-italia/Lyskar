{
	"dialogs":
	[
	{
		"who":
			{
				"name":"speaker_1"
			},
		"where":
			{
				"place":"park",
				"time":"night"
			},
		"what":
			[
				{
					"expression":"normal",
					"type":3,
					"action":"entrance",
					"text":"HEY! LISTEN!"
				},
				{
					"expression":"happy",
					"type":0,
					"text":"Hi! And welcome to the VNEngine made for Lyskar: the best visual novel made in Godot Engine!"
				},
				{
					"expression":"funny",
					"type":0,
					"action":"tremble",
					"text":"My name is @NAME and this is an example of a dialog line..."
				},
				{
					"expression":"question",
					"type":1,
					"text":"Do you like it?",
					"action":"back",
					"options": 
						[
							"Yes, I like it!", 
							"No, it looks like poop.", 
							"Meh, it could be improved... I guess?"
						]
				},
				{
					"type":2,
					"action":"front",
					"0":
						{
							"expression":"happy",
							"type":0,
							"text":"I'm so glad you like it!",
							"action":"answer_positive"
						},
					"1": 
						{
							"expression":"sad",
							"type":0,
							"text":"Oh... Okay.",
							"action":"answer_negative"
						},
					"2":  {
							"expression":"question",
							"type":0,
							"text":"Mhh... yeah, maybe you are right."
						}
				},
				{
					"expression":"happy",
					"type":0,
					"text":"Well, it was nice to talk with you... have a good day!"
				},
				{
					"expression":"normal",
					"type":3,
					"action":"exit",
					"text":"Bye byeeeee~"
				}
			]
	},
	{
		"who":{},
		"where":{},
		"what":{}
	},
	{
		"who":{},
		"where":{},
		"what":{}
	},	
	]
}