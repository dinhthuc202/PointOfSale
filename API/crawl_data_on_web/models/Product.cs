using System.ComponentModel.DataAnnotations;


namespace crawl_data_on_web.models
{

    public class ProductInput
    {
        [Required]
        public string Name { get; set; } = string.Empty;
        [Required]
        public decimal PurchasePrice { get; set; }
        [Required]
        public decimal SalePrice { get; set; }
        public decimal TotalPiece { get; set; }

        [Required]
        public bool Saleable { get; set; }
        [Required]
        public int SupplierId { get; set; }
        public string? Image { get; set; }
    }
}

