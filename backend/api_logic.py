from flask import Flask,jsonify, request
import base64
import json
import requests
import bav_scraper

# with open("./../assets/graph.png","rb") as img:
#     encoded_img = base64.b64encode(img.read())

# serialized_img = encoded_img.decode('utf-8')

app = Flask(__name__)


@app.route('/userInput',methods=['POST','GET'])
def userInput():
    data = request.json
    print(data["Steuerklasse"])
    
    bot = bav_scraper.bAVBot(data["Brutto-verdienst"],data["bAV"],data["Steuerklasse"])
    bot.execute_bot()


    return json.dumps({"image": bot.screenshot})

# return jsonify({"image":json.dumps(serialized_img)})

if __name__ == '__main__':
    app.run(debug=True)
