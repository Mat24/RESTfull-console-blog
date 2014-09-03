#Script para probar los servicios web de una aplicacion creada en ruby on rails con un scaffold 
#rails g scaffold Blog titulo:string contenido:text
#Script Creado por Mat24
 
require 'pp'
require 'httparty'
class Partay
  include HTTParty
  @url_base = 'http://localhost:3000' 
  base_uri @url_base
  def initialize(titulo,contenido)
    @titulo = titulo
    @contenido = contenido   
  end
  def set_titulo
    @titulo = titulo
  end 
  def set_contenido
    @contenido = contenido
  end
  def crear_json
    return json = 
    {
    body:
      {
	blog: 
	{ # clase modelo
	    titulo: "#{@titulo}", # Columnas de la tabla
	    contenido: "#{@contenido}"
	}
      }
    }
  end
end
def esperar
  gets
end
loop do
  system "clear"
  puts "Consumidor de servicios WEB para aplicacion Blog"
  puts "1.Listar entradas"
  puts "2.Crear entradas"
  puts "3.Modificar entrada"
  puts "4.Eliminar entrada"
  puts "5.Salir"
  opcion = gets.chomp.to_i
  case opcion
  when 1
    pp Partay.get('/blogs.json')
    esperar
  when 2
    puts "Escriba el titulo de la nueva entrada"
    titulo = gets.chomp
    puts "Escriba el contenido"
    contenido = gets.chomp
    nueva_entrada = Partay.new(titulo,contenido)
    pp Partay.post('/blogs.json', nueva_entrada.crear_json)
    puts "Entrada creada satisfactoriamente!"
    esperar
  when 3
    puts "Porfavor digite el id de la entrada"
    id = gets.chomp.to_i
    pp Partay.get("/blogs/#{id}.json")
    puts "Digite el nuevo titulo"
    nuevo_titulo = gets.chomp
    puts "Dgite el nuevo contenido"
    nuevo_contenido = gets.chomp
    puts "Actualizando..."
    entrada_modificada = Partay.new(nuevo_titulo,nuevo_contenido)
    pp Partay.put("/blogs/#{id}.json",entrada_modificada.crear_json)
    puts "Actualizacion satisfactoria"  
    esperar
  when 4
    puts "Porfavor digite el id de la entrada a eliminar"
    id = gets.chomp.to_i
    pp Partay.get("/blogs/#{id}.json")
    puts "Esta seguro que desea eliminar esta entrada? (S/N)"
    respuesta = gets.chomp.upcase
    case respuesta
    when 'S'
      pp Partay.delete("/blogs/#{id}.json")
      puts "Entrada eliminada con exito"
      esperar
    when 'N'
      puts "Operacion cancelada"
      esperar
    end
  when 5
    break
  end
end
