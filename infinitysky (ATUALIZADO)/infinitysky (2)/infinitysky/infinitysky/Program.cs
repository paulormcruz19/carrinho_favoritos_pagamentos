using infinitysky.CarrinhoCompra;
using infinitysky.Repository;
using InfinitySky.Libraries.Login;

var builder = WebApplication.CreateBuilder(args);

// Adicionar servi�os ao container
builder.Services.AddControllersWithViews();

// Adicionado para manipular a Sess�o
builder.Services.AddHttpContextAccessor();

// Adicionar a Interface como um servi�o 
builder.Services.AddScoped<IClienteRepository, ClienteRepository>();
builder.Services.AddScoped<IPlanosRepositorio, PlanosRepositorio>();

// Adicionar CookieCarrinhoCompra
builder.Services.AddScoped<CookieCarrinhoCompra>();
builder.Services.AddScoped<CookieFavoritos>();
builder.Services.AddScoped<infinitysky.Cookie.Cookie>();

// Adicionar servi�os de Sess�o e Login
builder.Services.AddScoped<InfinitySky.Libraries.Sessao.Sessao>();
builder.Services.AddScoped<LoginCliente>();

// Configurar sess�o
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30); // Tempo de expira��o da sess�o
    options.Cookie.HttpOnly = true; // Seguran�a do cookie
    options.Cookie.IsEssential = true; // Necess�rio para o funcionamento essencial do site
});

var app = builder.Build();

// Configurar o pipeline de tratamento de requisi��es HTTP
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts(); // For�a o uso de HSTS em ambientes n�o de desenvolvimento
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

// Adicionar middleware de sess�o
app.UseSession();

app.UseAuthorization();

// Configura��o das rotas
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();