using infinitysky.Models;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System.Collections.Generic;

namespace infinitysky.CarrinhoCompra
{
    public class CookieFavoritos
    {
        private readonly IHttpContextAccessor _contextAccessor;
        private readonly string Key = "Favoritos";

        public CookieFavoritos(IHttpContextAccessor contextAccessor)
        {
            _contextAccessor = contextAccessor;
        }

        public void Cadastrar(Planos plano)
        {
            // Obtém a lista atual de favoritos armazenada no cookie
            List<Planos> favoritos = Consultar();

            // Verifica se o plano já está na lista de favoritos
            if (!favoritos.Exists(p => p.IdPlano == plano.IdPlano))
            {
                // Adiciona o plano à lista de favoritos
                favoritos.Add(plano);

                // Atualiza o cookie com a nova lista
                Atualizar(favoritos);
            }
        }

        public List<Planos> Consultar()
        {
            // Obtém o cookie dos favoritos
            var favoritos = _contextAccessor.HttpContext.Request.Cookies[Key];

            // Se não houver cookie, retorna uma lista vazia
            if (string.IsNullOrEmpty(favoritos))
            {
                return new List<Planos>();
            }

            // Se o cookie existir, converte-o de volta para a lista de objetos Planos
            return JsonConvert.DeserializeObject<List<Planos>>(favoritos);
        }


        public void Remover(Planos plano)
        {
            List<Planos> favoritos = Consultar();
            favoritos.RemoveAll(p => p.IdPlano == plano.IdPlano);
            Atualizar(favoritos);
        }

        private void Atualizar(List<Planos> favoritos)
        {
            var favoritosJson = JsonConvert.SerializeObject(favoritos);
            CookieOptions options = new CookieOptions
            {
                Expires = DateTime.Now.AddDays(7),
                IsEssential = true
            };

            _contextAccessor.HttpContext.Response.Cookies.Append(Key, favoritosJson, options);
        }
    }
}
