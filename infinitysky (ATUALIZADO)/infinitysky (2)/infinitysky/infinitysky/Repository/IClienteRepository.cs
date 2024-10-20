using infinitysky.Models;

namespace infinitysky.Repository
{
    public interface IClienteRepository
    {
        // CRUD
        //login
        // Em verde model, amarelo = método (dentro dele  está as funçoes do sql(select, insert, etc))
        Cliente Login(string Email, string Senha);


        // listar 
        //excluir

        //cadastrar cliente 
        //void sem retorno 
        void Cadastrar(Cliente cliente);
    }
}
