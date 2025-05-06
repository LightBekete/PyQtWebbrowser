# this web server uses the aiohttp module whic has asyncio function inbuilt


import aiohttp
from aiohttp import web
from pathlib import Path

# creating routes that will handle get and post method
routes = web.RouteTableDef()
routes.static("/static", Path(__file__).parent/"assets")

@routes.get("/")
async def handle_index(request):
    try:
        with open(Path(__file__).parent/"templates/index.html", "r") as open_index:
            index_content = open_index.read()
        
        return web.Response(text=index_content, content_type="text/html")
    
    except FileNotFoundError as e:
        return web.Response(text="web page not found",status=404)
    
@routes.get("/register")
async def handle_register(request):
    try:
        with open(Path(__file__).parent/"templates/register.html", "r") as open_register:
            register_content = open_register.read()
            
        return web.Response(text=register_content, content_type="text/html")
    except FileNotFoundError as e:
        return web.Response(text="The register web Pahe is Not found", status=404)
    
@routes.post("/submit")
async def handle_submit(request):
    
    #parsing the form data from the registration form
    submit_data = await request.post()
    
    username = submit_data.get("username", "").strip()
    email = submit_data.get("email","").strip()
    
    if username and email:
        try:
            with open(Path(__file__).parent/"db.txt", "a") as account_appends:
                account_appends.write(f"{username} {email}\n")
            return web.Response(text="Account has been succesfully been added to the database",
                                content_type="text/plain", status=200)
        except FileNotFoundError as e:
            return web.Response(text="datbase file not found", status=404)
    else:
        return web.Response(text="invalid data", status=404)
    
    
    
app = web.Application()
app.add_routes(routes)

PORT = 8085
HOST = "localhost"

if __name__ == "__main__":
    # creating and starting an asyncio event loop of http type of the aiohhttp module
    web.run_app(app,host=HOST,port=PORT)