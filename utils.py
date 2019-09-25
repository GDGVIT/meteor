import os
import sqlite3
from sqlite3 import Error


def getConnectionDB():
    conn = None
    if not os.path.exists("./data.db"):
        conn = sqlite3.connect("./data.db")
        cur = conn.cursor()
        db_init_file = open("./res/db_init.sql", "r")
        cur.execute(db_init_file.read())
        conn.commit()
        db_init_file.close()
    else:
        conn = sqlite3.connect("./data.db")
    conn.row_factory = sqlite3.Row
    return conn

conn = getConnectionDB()

def getDefaultProfilePictureUrl():
    return "file:///" + os.path.join(os.path.dirname(__file__), "res", "default_profile_picture.jpg")


def getContactsFromDB():
    cur = conn.cursor()
    cur.execute("SELECT * FROM contacts")
    rows = cur.fetchall()
    model_data = []
    url = getDefaultProfilePictureUrl()
    for row in rows:
        model_data.append({"name": row["name"], "recentText": row["recent_text"], "dhtId": row["dht_id"], "status": 1, "msgCount": 0, "imageUrl": url})
    return model_data

def loadChatFromDB(chatId, chat_model_provider):
    prefixedChatId = "meteor_" + chatId
    sql_query = f'''CREATE TABLE IF NOT EXISTS {prefixedChatId} (
    id integer PRIMARY KEY,
    isRightBubble integer NOT NULL,
    bubbleData text
    )'''

    cur = conn.cursor()
    cur.execute(sql_query)
    conn.commit()

    cur.execute(f"SELECT * from {prefixedChatId}")
    rows = cur.fetchall()

    for row in rows:
        chat_model_provider.model.appendRow({"name": "x", "bubbleData": row["bubbleData"], "isRightBubble": row["isRightBubble"], "applyBubbleSpace": True, "renderBubbleOutgrowth": True})

def addChatToDB(chatId, row):
    cur = conn.cursor()
    isRightBubble = row["isRightBubble"]
    bubbleData = row["bubbleData"]
    prefixedChatId = "meteor_" + chatId
    cur.execute(f"insert into {prefixedChatId} (isRightBubble, bubbleData) values ('{isRightBubble}', '{bubbleData}')")
    conn.commit()

def addContactToDB(dhtId, name):
    sql_query = f"insert into contacts (dht_id, name) values ('{dhtId}', '{name}')"
    cur = conn.cursor()
    cur.execute(sql_query)
    conn.commit()





