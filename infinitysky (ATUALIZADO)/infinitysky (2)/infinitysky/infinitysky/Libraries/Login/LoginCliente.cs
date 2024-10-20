using infinitysky.Models;
using Newtonsoft.Json;


namespace InfinitySky.Libraries.Login

{
    public class LoginCliente
    {


        //injeção de depencia
        private string Key = "Login.Cliente";
        private Sessao.Sessao _sessao;

        //Construtor
        public LoginCliente(Sessao.Sessao sessao)
        {
            _sessao = sessao;
        }

        public void Login(Cliente cliente)
        {
            // Serializar- Com a serialização é possível salvar objetos em arquivos de dados
            string clienteJSONString = JsonConvert.SerializeObject(cliente);

        }

        public Cliente GetCliente()
        {
            /* Deserializar-Já a desserialização permite que os 
            objetos persistidos em arquivos possam ser recuperados e seus valores recriados na memória*/

            if (_sessao.Existe(Key))
            {
                string clienteJSONString = _sessao.Consultar(Key);
                return JsonConvert.DeserializeObject<Cliente>(clienteJSONString);
            }
            else
            {
                return null;
            }
        }

        //Remove a sessão e desloga o Cliente
        public void Logout()
        {
            _sessao.RemoverTodos();
        }

    }
}

