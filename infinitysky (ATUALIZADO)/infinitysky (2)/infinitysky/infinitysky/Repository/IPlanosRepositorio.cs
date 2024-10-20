using infinitysky.Models;

namespace infinitysky.Repository
{
    public interface IPlanosRepositorio
    {
        List<Planos> ObterPlanosAleatorios(int quantidade);
        IEnumerable<Planos> PesquisaPlanos(string Nome);

        void Adicionar(Planos plano);
        // void Atualizar(Planos plano); // Se necessário
        Planos ObterPlano(long Id);
        void Apagar(long Id);
    }
}
