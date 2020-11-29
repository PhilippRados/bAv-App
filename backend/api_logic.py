from flask import Flask,jsonify, request,abort
from functools import wraps
import base64
import json
import requests
import bav_scraper
from privates import APP_KEY

app = Flask(__name__)


def require_appkey(view_function):
    @wraps(view_function)
    # the new, post-decoration function. Note *args and **kwargs here.
    def decorated_function(*args, **kwargs):
        if request.json['key'] and request.json['key'] == APP_KEY:
            return view_function(*args, **kwargs)
        else:
            abort(401)
    return decorated_function


@app.route('/userInput',methods=['POST','GET'])
@require_appkey
def userInput():
    data = request.json

    bot = bav_scraper.bAVBot(data["Brutto-verdienst"],data["bAV"],data["Steuerklasse"])
    bot.execute_bot()


    return json.dumps({"image": bot.screenshot,
                    "NettoAufwand_bAV":bot.nettoAufwand,
                    "SteuerErsparnis":bot.steuerErsparnis
    })


if __name__ == '__main__':
    app.run(debug=True)
