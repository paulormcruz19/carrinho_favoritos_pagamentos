using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace infinitysky.Models
{
    public class Planos
    {
        [DisplayName("Código do Plano")]
        public Int64 IdPlano { get; set; }

        [Required(ErrorMessage = " O nome do plano é obrigatório")]
        [StringLength(100)]
        [DisplayName("Nome")]
        public string Nome { get; set; }

        [Required(ErrorMessage = "A hospedagem é obrigatória")]
        [StringLength(100)]
        [DisplayName("Hospedagem")]
        public string HospedagemPlano { get; set; }

        [Required(ErrorMessage = "O curso é obrigatório")]
        [StringLength(100)]
        [DisplayName("Curso")]
        public string CursoPlano { get; set; }

        [Required(ErrorMessage = "A instituição é obrigatória")]
        [StringLength(150)]
        [DisplayName("Instituição")]
        public string InstituicaoPlano { get; set; }

        [Required(ErrorMessage = "O período é obrigatório")]
        [StringLength(20)]
        [DisplayName("Período")]
        public string PeriodoPlano { get; set; }

        [Required(ErrorMessage = "A descrição é obrigatória")]
        [DisplayName("Descrição do Plano")]
        public string DescricaoPlano { get; set; }

        [Required(ErrorMessage = "A imagem é obrigatória")]
        [DisplayName("Imagem do Plano")]
        public string image_plano { get; set; }

        [Required(ErrorMessage = "O valor é obrigatório")]
        [DisplayFormat(DataFormatString = "{0:0.00}")]
        [DisplayName("Preço")]
        public decimal Valor { get; set; }

        [Required(ErrorMessage = "O ID do país é obrigatório")]
        [DisplayName("País")]
        public int IdPais { get; set; } // Referência ao país

        [Required(ErrorMessage = "A máxima parcela do plano é obrigatória")]
        [DisplayName("Parcela")]
        public string ParcelaPlano { get; set; } // Referência a parcela

        [Required(ErrorMessage = "A quantidade em estoque é obrigatória")]
        [DisplayName("Quantidade em estoque")]
        public int QtdPlano { get; set; }
    }
}
