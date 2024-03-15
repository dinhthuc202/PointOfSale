using System.ComponentModel.DataAnnotations;

namespace API_POS.models
{
    public class Supplier
    {
        public int? Id { get; set; }
        [StringLength(64)]
        [Required]
        public string? Name { get; set; }
        [StringLength(128)]
        public string? Address { get; set; }
        public decimal? Balance { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        //public BusinessInfo? business { get; set; }
        public string? BizId { get; set; }
    }

    public class SupplierInput
    {
        [StringLength(64)]
        [Required]
        public string? Name { get; set; }
        [StringLength(128)]
        public string? Address { get; set; }
        public decimal? Balance { get; set; }
        public string? BizId { get; set; }
    }

    public class SupplierEdit
    {
        public int? Id { get; set; }
        [StringLength(64)]
        [Required]
        public string? Name { get; set; }
        [StringLength(128)]
        public string? Address { get; set; }
        public decimal? Balance { get; set; }
        public string? BizId { get; set; }
    } 
}
