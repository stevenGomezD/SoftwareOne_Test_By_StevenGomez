import requests
import json
import html
import argparse

#Esta funcion realiza una petición GET a la API dragonball-api
#Recibe como parametreo el ID del personaje
def get_dragonball_data(id: str):
    #Procesar el parametro
    id_param = str(id).split(":")[1][1:2]
    url = f"https://dragonball-api.com/api/characters/{id_param}"
    
    #Request GET
    response = requests.get(url)
    if response.status_code == 200:
        print("Response API Exitosa")
        return response.json()
    else:
        print("Response API Fallida")
        return None

#Esta funcion crea un archivo JSON en el cual almacena el response 
#de la solicitud a la API 
def save_json_to_file(data, filename="Python_Scripts/dragonball_data.json"):
    if data:
        with open(filename, "w") as file:
            json.dump(data, file, indent=4)
            print("Response archivo JSON creado con exito")
    else:
        print("Response archivo JSON no se ha creado")

#Esta funcion crea un arhivo HTML a partir del response de la API en formato JSON 
def generate_html_from_json(json_file, html_file="Python_Scripts/dragonball_character.html"):
    # Leer el archivo JSON
    with open(json_file, 'r') as json_file:
        data = json.load(json_file)
    
    # Extraer la información requerida
    character_id = data.get('id')
    name = data.get('name')
    max_ki = data.get('maxKi')
    race = data.get('race')
    description = data.get('description')
    affiliation = data.get('affiliation')
    image = data.get('image')
 
    # Crear contenido HTML
    html_content = f"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Character Information</title>
        <style>
            body {{ font-family: Arial, sans-serif; margin: 20px; }}
            .container {{ max-width: 600px; margin: 0 auto; }}
            img {{ max-width: 100%; height: auto; }}
            h1 {{ color: #333; }}
            p {{ line-height: 1.6; }}
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Character Information</h1>
            <p><strong>ID:</strong> {html.escape(str(character_id))}</p>
            <p><strong>Name:</strong> {html.escape(name)}</p>
            <p><strong>Max Ki:</strong> {html.escape(max_ki)}</p>
            <p><strong>Race:</strong> {html.escape(race)}</p>
            <p><strong>Description:</strong> {html.escape(description)}</p>
            <p><strong>Affiliation:</strong> {html.escape(affiliation)}</p>
            <p><strong>Image:</strong><br><img src="{html.escape(image)}" alt="{html.escape(name)}"></p>
        </div>
    </body>
    </html>
    """
 
    # Guardar el contenido HTML en un archivo
    with open(html_file, 'w') as html_file:
        html_file.write(html_content)
        
    print(f"Archivo HTML con la información de {name} generado")

#Funcion principal
def main():
    #Configurar el argumento de entrada
    parser = argparse.ArgumentParser()
    parser.add_argument("Id del personaje", type=int, help="Ingrese un Id entre el 1 al 9")
    args = parser.parse_args()
    
    # Paso 1: Obtener los datos de la API
    data = get_dragonball_data(args)
    
    # Paso 2: Guardar los datos en un archivo JSON
    save_json_to_file(data)
    
    # Paso 3: Generar el archivo HTML a partir del JSON
    generate_html_from_json("dragonball_data.json")

 
if __name__ == "__main__":
    main()