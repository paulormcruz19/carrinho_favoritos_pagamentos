using infinitysky.CarrinhoCompra;
using infinitysky.Repository;
using InfinitySky.Libraries.Login;

var builder = WebApplication.CreateBuilder(args);

// Adicionar serviços ao container
builder.Services.AddControllersWithViews();

// Adicionado para manipular a Sessão
builder.Services.AddHttpContextAccessor();

// Adicionar a Interface como um serviço 
builder.Services.AddScoped<IClienteRepository, ClienteRepository>();
builder.Services.AddScoped<IPlanosRepositorio, PlanosRepositorio>();

// Adicionar CookieCarrinhoCompra
builder.Services.AddScoped<CookieCarrinhoCompra>();
builder.Services.AddScoped<CookieFavoritos>();
builder.Services.AddScoped<infinitysky.Cookie.Cookie>();

// Adicionar serviços de Sessão e Login
builder.Services.AddScoped<InfinitySky.Libraries.Sessao.Sessao>();
builder.Services.AddScoped<LoginCliente>();

// Configurar sessão
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30); // Tempo de expiração da sessão
    options.Cookie.HttpOnly = true; // Segurança do cookie
    options.Cookie.IsEssential = true; // Necessário para o funcionamento essencial do site
});

var app = builder.Build();

// Configurar o pipeline de tratamento de requisições HTTP
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts(); // Força o uso de HSTS em ambientes não de desenvolvimento
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

// Adicionar middleware de sessão
app.UseSession();

app.UseAuthorization();

// Configuração das rotas
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();