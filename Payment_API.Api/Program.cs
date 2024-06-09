using Hangfire;
using Payment_API.Api.Services;
using Payment_API.Application.Features.Commands;
using Payment_API.Application.Interface;
using Payment_API.Persistence.Persist;
using Payment_API.Service.Momo.Config;
using Payment_API.Service.VnPay.Config;
using Payment_API.Service.ZaloPay.Config;
using System.Reflection;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo()
    {
        Version = "v1",
        Title = "Payment service api",
        Description = "sample asp.net payment api",
        Contact = new Microsoft.OpenApi.Models.OpenApiContact
        {
            Name = "Tien Haui",
            Url = new Uri("https://tienhaui.com")
        }
    });
    var xmlFileName = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var path = Path.Combine(AppContext.BaseDirectory, xmlFileName);
    options.IncludeXmlComments(path);
});
// Resgister DI
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<ISqlService, SqlService>();
builder.Services.AddScoped<ICurrentUserService, CurrentUserService>();
builder.Services.AddScoped<IConnectionService, ConnectionService>();
builder.Services.AddMediatR(r =>
{
    r.RegisterServicesFromAssemblies(typeof(CreateMerchant).Assembly);
});
// config vnpay
builder.Services.Configure<VnPayConfig>(
                builder.Configuration.GetSection(VnPayConfig.ConfigName));
// config momo
builder.Services.Configure<MomoConfig>(
                builder.Configuration.GetSection(MomoConfig.ConfigName));
// config zalopay
builder.Services.Configure<ZaloPayConfig>(
                builder.Configuration.GetSection(ZaloPayConfig.ConfigName));
// cấu hình hangfire
builder.Services.AddHangfire(configuration =>
{
    configuration.SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
    .UseSimpleAssemblyNameTypeSerializer()
    .UseRecommendedSerializerSettings()
    .UseSqlServerStorage(builder.Configuration.GetConnectionString("Payment_API"),
        new Hangfire.SqlServer.SqlServerStorageOptions()
        {
            // TO DO : change hangfire sql server options
        });
});
builder.Services.AddHangfireServer();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseHangfireDashboard();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
