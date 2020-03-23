import hexchat
from random import choice, randint
__module_name__ = "colormanip"
__module_author__ = "belzurix"
__module_version__ = "1"
__module_description__ = "Convert text to different colours with bold face"

colors = [5, 4, 7, 8, 3, 9, 10, 11, 2, 12, 6, 13]
color_count = len(colors)

chars_neutral = " ,"
chars_control = "\x01-\x1f\x7f-\x9f"

regex_chars = "[^%(n)s%(s)s][%(n)s%(s)s]*" % { 'n': chars_neutral, 's': chars_control }
regex_words = "[^%(n)s]+[%(n)s%(s)s]*" % { 'n': chars_neutral, 's': chars_control }


def bang_cb(word, word_eol, userdata):
	hexchat.command("SAY .bang")


def satan_cb(word, word_eol, userdata):
	new = "\x02\x0304,01" + "\u26E7 " + (" ".join(word[1:])) + " \u26E7"
	hexchat.command("SAY {0}".format(new))

def red_cb(word, word_eol, userdata):
	new = "\x0304" + "\u262D " + (" ".join(word[1:])) + " \u262D"
	hexchat.command("SAY {0}".format(new))

def rev_cb(word, word_eol, userdata):
        hexchat.command("SAY ----\u20AC {}".format(" ".join(word[1:])))

hexchat.hook_command("satan", satan_cb)
hexchat.hook_command("commie", red_cb)
hexchat.hook_command("revolt", rev_cb)
hexchat.hook_command("b", bang_cb)

hexchat.prnt(__module_name__ + " version " + __module_version__ + " loaded")

pairs = {'a':"ä",
         'b':"b̈",
         'c':"c̈",
         'd':"ḋ",
         'e':"ë",
         'f':"ḟ",
         "g":"ġ",
         'h':"ḧ",
         'i':'ï',
         'j':"j̈",
         'k':'k̈',
         'l':"l̇",
         'm':'m̈',
         'n':'n̈',
         'o':"ö",
         'p':'p̈',
         'q':'q̈',
         'r':"ȑ",
         's':'s̈',
         't':'ẗ',
         'u':'ᴞ',
         'v':'v̈',
         'w':'ẅ',
         'x':'ẍ',
         'y':'ÿ',
         'z':'z̈'}

def uml_cb(word, word_eol, userdata):
        text=" ".join(word[1:])
        for key, value in pairs.items():
                #hexchat.prnt(key)
                text=text.replace(key, value)
                #hexchat.prnt(text)

        
        hexchat.command("SAY {0}".format(text))

hexchat.hook_command("uml", uml_cb)


def interject_cb(word, word_eol, userdata):
	hexchat.command("""NCTCP {0} I'd just like to interject for a moment.  What you're referring to as gnulag, is in fact, snoonet/#gnulag, or as I've recently taken to calling it, snoonet plus #gnulag. #gnulag is not a network unto itself, but rather another free component of the fully functioning snoonet network made useful by the snoonet team, gonzobot utilities and vital regulars comprising a full community as defined by browndawg.""".format(word[1]))
	hexchat.command("""NCTCP {0} Many computer users join a modified channel of the snoonet network every day, without realizing it. Through a peculiar turn of events, the version of snoonet which is widely used today is often called gnulag, and many of its users are not aware that it is basically the snoonet network, administered by goddamn prawnsalad.""".format(word[1]))
	hexchat.command("""NCTCP {0} There really is a gnulag, and these people are joining it daily, but it is just a part of the network they use. gnulag is the kernel: the channel in the network that draws more users to the other channels that you join. #gnulag is an essential channel of the network, but useless by itself; it can only function in the context of a complete IRC network. gnulag is normally used in combination with the snoonet network: the whole system is basically snoonet with gnulag added, or snoonet/#gnulag.  All the so-called "gnulag" instances are really instances of snoonet/#gnulag.""".format(word[1]))

hexchat.hook_command("interject", interject_cb)

def dumb_cb(word, word_eol, userdata):
	word=word[1:]
	for wIndex, w in enumerate(word):
		t = list(w)
		for index, c in enumerate(t):
			if index%2:
				t[index]=c.upper()
		word[wIndex]="".join(t)
	text=" ".join(word)
	hexchat.command("SAY {0}".format(text))

hexchat.hook_command("dumb", dumb_cb)
