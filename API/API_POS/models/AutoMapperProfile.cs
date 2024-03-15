using AutoMapper;

namespace API_POS.models
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<UserSignIn, User>();

            CreateMap<SOInput, SO>();
            CreateMap<SODInput, SOD>();

            CreateMap<ProductInput, Product>();
            CreateMap<ProductEdit, Product>();

            CreateMap<CustomerInput, Customer>();
            CreateMap<CustomerEdit, Customer>();

            CreateMap<SupplierInput, Supplier>();
            CreateMap<SupplierEdit, Supplier>();


        }
    }
}
