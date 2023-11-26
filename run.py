from flaskblog import create_app, socketio

app = create_app()

if (__name__ == "__main__"):  # run directly else run from import(other file importing this file)
    socketio.run(app,debug=True)
    # app.run(debug=True)  #ensure that we can run fluently with changes instead of running again and again
"""
    pip install beautifulsoup4
    pip install lxml ->>compiler
    pip install html5lib
    pip install requests
"""

