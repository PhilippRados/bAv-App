from flask import Flask,jsonify, request
import base64
import json
import requests
import bav_scraper



app = Flask(__name__)


@app.route('/userInput',methods=['POST','GET'])
def userInput():
    data = request.json
    print(data["Steuerklasse"])
    
    bot = bav_scraper.bAVBot(data["Brutto-verdienst"],data["bAV"],data["Steuerklasse"])
    bot.execute_bot()


    return json.dumps({"image": bot.screenshot})


if __name__ == '__main__':
    app.run(debug=True)
