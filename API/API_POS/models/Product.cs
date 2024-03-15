using System.ComponentModel.DataAnnotations;

namespace API_POS.models
{
    public class Product
    {
        public int? Id { get; set; }
        [Required]
        public string Name { get; set; } = string.Empty;
        [Required]
        public decimal PurchasePrice { get; set; }
        [Required]
        public decimal SalePrice { get; set; }
        public decimal? Stock { get; set; }
        public int? PerPack { get; set; }
        [Required]
        public decimal TotalPiece { get; set; }
        [Required]
        public bool Saleable { get; set; }
        public string? RackPosition { get; set; }
        [Required]
        public int SupplierId { get; set; }
        public string? Image { get; set; }
        public string? Remarks { get; set; }
        public string? BarCode { get; set; }
        public int? ReOrder { get; set; }
        public int? LocationId { get; set; }
        public int? CategoryId { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
    }

    public class ProductInput
    {
        [Required]
        public string Name { get; set; } = string.Empty;
        [Required]
        public decimal PurchasePrice { get; set; }
        [Required]
        public decimal SalePrice { get; set; }
        public decimal? Stock { get; set; }
        public int? PerPack { get; set; }
        [Required]
        public decimal TotalPiece { get; set; }
        [Required]
        public bool Saleable { get; set; }
        public string? RackPosition { get; set; }
        [Required]
        public int SupplierId { get; set; }
        public string? Image { get; set; }
        public string? Remarks { get; set; }
        public string? BarCode { get; set; }
        public int? ReOrder { get; set; }
        public int? LocationId { get; set; }
        public int? CategoryId { get; set; }
    }
    public class ProductEdit:ProductInput
    {
        public int? Id { get; set; }

    }
}
