using Newtonsoft.Json;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using infinitysky.Models;

namespace infinitysky.CarrinhoCompra
{
    public class CookieCarrinhoCompra
    {
        private const string CookieCarrinho = "CarrinhoCompra";
        private readonly IHttpContextAccessor _httpContextAccessor;

        public CookieCarrinhoCompra(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public void Cadastrar(Planos item)
        {
            var carrinho = Consultar() ?? new List<Planos>();
            carrinho.Add(item);
            SalvarCarrinho(carrinho);
        }

        public List<Planos> Consultar()
        {
            if (_httpContextAccessor.HttpContext.Request.Cookies.TryGetValue(CookieCarrinho, out var json))
            {
                return JsonConvert.DeserializeObject<List<Planos>>(json);
            }
            return null;
        }

        public void DiminuirPlano(Planos item)
        {
            var carrinho = Consultar();
            if (carrinho != null)
            {
                var plano = carrinho.Find(p => p.IdPlano == item.IdPlano);
                if (plano != null)
                {
                    // Lógica para diminuir a quantidade ou remover se necessário
                    carrinho.Remove(plano);
                    SalvarCarrinho(carrinho);
                }
            }
        }

        public void Remover(Planos item)
        {
            var carrinho = Consultar();
            if (carrinho != null)
            {
                carrinho.RemoveAll(p => p.IdPlano == item.IdPlano);
                SalvarCarrinho(carrinho);
            }
        }

        private void SalvarCarrinho(List<Planos> carrinho)
        {
            var json = JsonConvert.SerializeObject(carrinho);
            _httpContextAccessor.HttpContext.Response.Cookies.Append(CookieCarrinho, json);
        }
    }
}
