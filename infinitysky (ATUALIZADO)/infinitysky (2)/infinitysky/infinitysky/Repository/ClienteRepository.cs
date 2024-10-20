using infinitysky.Models;
using MySql.Data.MySqlClient;
using MySqlX.XDevAPI;
using System.Data;

namespace infinitysky.Repository
{
    public class ClienteRepository : IClienteRepository
    {

        //declarando a varival de da string de conxão

        private readonly string? _conexaoMySQL;

        //metodo da conexão com banco de dados
        public ClienteRepository(IConfiguration conf) => _conexaoMySQL = conf.GetConnectionString("ConexaoMySQL");

        //Login Cliente(metodo )

        public Cliente Login(string Email, string Senha)
        {
            //usando a variavel conexao 
            using (var conexao = new MySqlConnection(_conexaoMySQL))
            {
                //abre a conexão com o banco de dados
                conexao.Open();

                // variavel cmd que receb o select do banco de dados buscando email e senha
                MySqlCommand cmd = new MySqlCommand("select * from Cliente_tbl where email_cliente = @email_cliente and senha_cliente = @senha_cliente", conexao);

                //os paramentros do email e da senha 
                cmd.Parameters.Add("@email_cliente", MySqlDbType.VarChar).Value = Email;
                cmd.Parameters.Add("@senha_cliente", MySqlDbType.VarChar).Value = Senha;

                //Le os dados que foi pego do email e senha do banco de dados
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                //guarda os dados que foi pego do email e senha do banco de dados
                MySqlDataReader dr;

                //instanciando a model cliente
                Cliente cliente = new Cliente();
                //executando os comandos do mysql e passsando paa a variavel dr
                dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                //verifica todos os dados que foram pego do banco e pega o email e senha
                while (dr.Read())
                {

                    cliente.Email = Convert.ToString(dr["email_cliente"]);
                    cliente.Senha = Convert.ToString(dr["senha_cliente"]);
                }
                return cliente;
            }
        }

        //Cadastrar CLIENTE

        public void Cadastrar(Cliente cliente) //instanciando a classe 
        {
            using (var conexao = new MySqlConnection(_conexaoMySQL))

            {
                conexao.Open();

                //Primeiro temos que inserir na tabela Cliente 
                // Inserir o telefone na tabela Telefone_tbl e recuperar o id gerado

                MySqlCommand cmd = new MySqlCommand("insert into Cliente_tbl (nome_cliente,email_cliente,senha_cliente,cpf_cliente,data_nascimento,telefone) values (@nome,@email,@senha,@cpf,@dataNascimento,@telefone)", conexao); // @: PARAMETRO

                cmd.Parameters.Add("@nome", MySqlDbType.VarChar).Value = cliente.Nome;
                cmd.Parameters.Add("@email", MySqlDbType.VarChar).Value = cliente.Email;
                cmd.Parameters.Add("@senha", MySqlDbType.VarChar).Value = cliente.Senha;
                cmd.Parameters.Add("@telefone", MySqlDbType.VarChar).Value = cliente.Telefone;
                cmd.Parameters.Add("@cpf", MySqlDbType.VarChar).Value = cliente.Cpf_Cliente;
                cmd.Parameters.Add("@dataNascimento", MySqlDbType.VarChar).Value = cliente.Data_Nascimento;

                cmd.ExecuteNonQuery();
                conexao.Close();
             
            }
         

        }
        //Listar todos os clientes 

        public IEnumerable<Cliente> TodosClientes()
        {
            List<Cliente> Clientlist = new List<Cliente>();

            using (var conexao = new MySqlConnection(_conexaoMySQL))
            {
                conexao.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT * from Cliente_tbl", conexao);

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                conexao.Close();

                

                foreach (DataRow dr in dt.Rows)
                {
                    Clientlist.Add(
                            new Cliente
                            {
                                Nome = (string)(dr["nome_cliente"]),
                                Telefone = (string)(dr["telefone"]),
                                Email = (string)(dr["email_cliente"]),
                                Cpf_Cliente = (string)(dr["cpf_cliente"]),
                                Senha = (string)(dr["senha_cliente"]),
                                Data_Nascimento = (string)(dr["data_nascimento"]),

                            });
                }
                return Clientlist;

            }
        }
    }
}

