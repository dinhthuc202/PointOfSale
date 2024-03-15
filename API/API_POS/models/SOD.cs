using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_POS.models
{
    public class SOD
    {
        public int? Auto { get; set; }
        public string? Soid { get; set; }
        public int? Sodid { get; set; }
        public int? ProductId { get; set; }
        public decimal? OpeningStock { get; set; }
        public int? Quantity { get; set; }
        public decimal? SalePrice { get; set; }
        public decimal? PurchasePrice { get; set; }
        public decimal? PerPack { get; set; }
        public bool? IsPack { get; set; }
        public bool? SaleType { get; set; }
        public decimal? Profit { get; set; }
        public string? Remarks { get; set; }
    }

    public class SODInput
    {
        public int? ProductId { get; set; }
       // public decimal? OpeningStock { get; set; }//Tồn kho ban đầu
        public int? Quantity { get; set; }
        public decimal? SalePrice { get; set; }
        public decimal? PurchasePrice { get; set; }
        public decimal? PerPack { get; set; }
        public bool? IsPack { get; set; }
    }
}
