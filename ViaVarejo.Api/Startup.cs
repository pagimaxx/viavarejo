using AutoMapper;
using Wevo.Infrastructure.CrossCutting.IoC;
using FluentValidation.AspNetCore;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using Serilog;
using Swashbuckle.AspNetCore.Swagger;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Http;
using ViaVarejo.Api.Attributes;
using ViaVarejo.Infrastructure.CrossCutting.Utilities;
using System.IO;
using System;

namespace ViaVarejo.Api
{
    /// <summary>
    /// Startup
    /// </summary>
    public class Startup
    {
        /// <summary>
        /// Configuration
        /// </summary>
        public IConfigurationRoot Configuration { get; }

        /// <summary>
        /// Startup
        /// </summary>
        public Startup(IHostingEnvironment env)
        {
            var builder = new ConfigurationBuilder()
            .SetBasePath(env.ContentRootPath)
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true)
            .AddEnvironmentVariables();

            Configuration = builder.Build();

        }

        /// <summary>
        /// This method gets called by the runtime. Use this method to add services to the container.
        /// </summary>
        /// <param name="services"></param>
        public void ConfigureServices(IServiceCollection services)
        {
            //MVC e Fluent Validation
            services
                .AddMvc(options => {
                    options.Filters.Add(new ApiExceptionFilter());
                })
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_1)
                .AddFluentValidation(fv => fv.RegisterValidatorsFromAssemblyContaining<Startup>());

            //Swagger
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc(Configuration["SwaggerVersion"].ToString(),
                new Info
                {
                    Title = Configuration["SwaggerTitle"].ToString(),
                    Version = Configuration["SwaggerVersion"].ToString(),
                    Description = Configuration["SwaggerDescription"].ToString(),
                    TermsOfService = "None",
                    Contact = new Contact { Name = Configuration["SwaggerContactName"].ToString(), Email = Configuration["SwaggerContactEmail"].ToString(), Url = Configuration["SwaggerContactUrl"].ToString() }
                });

                // Set the comments path for the Swagger JSON and UI.
                var xmlMainPath = Path.Combine(AppContext.BaseDirectory, "ViaVarejo.Api.xml");
                var xmlAppPath = Path.Combine(AppContext.BaseDirectory, "ViaVarejo.AppService.xml");
                c.IncludeXmlComments(xmlMainPath);
                c.IncludeXmlComments(xmlAppPath);
            });


            //Cors
            services.AddCors();

            //Lendo chaves no arquivo de configuracoes
            services.AddOptions();
            services.Configure<KeysConfig>(Configuration);

            //AutoMapper
            services.AddAutoMapper();

            //Injecao de dependencia nativa
            var ioc = new InjectorContainer();
            services = ioc.ObterScopo(services);

            services.AddSingleton<IConfiguration>(Configuration);
            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

            //Adicionar a compressão ao servico
            services.AddResponseCompression();
        }

        /// <summary>
        /// This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        /// </summary>
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseHsts();
            }

            app.UseCors(
                options => options.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader().AllowCredentials()
            );
            //app.UseHttpsRedirection();
            app.UseMvc();
            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", Configuration["SwaggerTitle"].ToString());
            });

            //Informando ao app que deve usar compressao
            app.UseResponseCompression();
        }
    }
}
