# custom_keywords.py
import pyperclip
import pyclip

# def copy_to_clipboard(text):
#     pyperclip.copy(text)

def copy_to_clipboard(text):
    with open('/tmp/clipboard.txt', 'w') as f:
        f.write(text)

def paste_from_clipboard():
    with open('/tmp/clipboard.txt', 'r') as f:
        return f.read()
