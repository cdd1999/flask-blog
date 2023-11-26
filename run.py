from flaskblog import create_app, socketio
from waitress import serve
import os

app = create_app()
env = os.environ.get('ENV')

if (__name__ == "__main__"):  # run directly else run from import(other file importing this file)
  if (env == 'prod'):
    serve(app)
  else:
    socketio.run(app, debug=True) # app.run(debug=True)
