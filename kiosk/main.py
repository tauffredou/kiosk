import json
import threading
import time

import requests

from flask import Flask
from flask import render_template
from flask import Response

from selenium import webdriver


class Kiosk:

    def __init__(self):
        self.data = {}
        self.handlers = {}

        self.on('init', self.init)

    def start(self):
        self.set_state('init')

    def set_state(self, state):
        self.data['state'] = state
        self.handlers[state]()

    def on(self, state, f):
        self.handlers[state] = f

    def init(self):

        not_started = True
        while not_started:
            try:
                r = requests.get('http://127.0.0.1:5000/api/state')
                if r.status_code == 200:
                    print('Server started, quiting start_loop')
                    not_started = False
            except:
                print('Server not yet started')
            time.sleep(1)

        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--disable-extensions')
        chrome_options.add_argument('--disable-popup-blocking')
        chrome_options.add_argument('--disable-feature=TranslateUI')
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument('--disable-infobars')
        chrome_options.add_argument('--start-fullscreen')
        chrome_options.add_argument('--start-maximized')
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--kiosk')

        self.driver = webdriver.Chrome(options=chrome_options)

        self.driver.get("http://localhost:5000/init")


app = Flask(__name__)

kiosk = Kiosk()


@app.route("/init")
def init():
    return render_template('init.html')


@app.route("/api/state")
def api_state():
    global kiosk
    resp = Response(json.dumps(kiosk.data), status=200, mimetype='application/json')
    return resp


if __name__ == "__main__":
    t = threading.Thread(target=kiosk.start)
    t.daemon = True
    t.start()
    app.run()
