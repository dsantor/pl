package com.dakiplast.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.session.SessionInformationExpiredStrategy;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
	
	@Autowired
	RestAuthenticationEntryPoint restAuthenticationEntryPoint;
	
	@Autowired
	CAuthenticationFailureHandler authenticationFailureHandler;
	
	@Autowired
	CustomAuthenticationProvider authenticationProvider;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private DataSource dataSource;
	
	@Value("${spring.queries.users-query}")
	private String userQuery;
	
	@Value("${spring.queries.roles-query}")
	private String rolesQuery;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		String password = bCryptPasswordEncoder.encode("a");
		auth
			.jdbcAuthentication()
			.usersByUsernameQuery(userQuery)
			.authoritiesByUsernameQuery(rolesQuery)
			.dataSource(dataSource)
			.passwordEncoder(bCryptPasswordEncoder);
//			
			auth.inMemoryAuthentication()
			.withUser("a").password(password).roles("ADMIN");
			
			auth.authenticationProvider(authenticationProvider);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		String[] publicRoutes = new String[] { "/","/error"}; // "/login" , "/homepage", 

		String[] userRoutes = new String[] {"/user/**"};

		String[] adminRoutes = new String[] { "/api", "/pages/secure/**", "/api/**", "/user/**", "/secure/**"}; //, "/login" , "/homepage", "/error", "/api/**", "/secure/**"

//		String[] publicRoutes = new String[] { "/**","/error"}; // "/login" , "/homepage", 
//
//		String[] userRoutes = new String[] {"/user/**"};
//
//		String[] adminRoutes = new String[] { "/api/**", "/pages/**"}; //, "/login" , "/homepage", "/error", "/api/**", "/secure/**"
		
		
		 http
		 .authorizeRequests()
//		 .antMatchers("/**").hasRole("ANONYMOUS")
		 .antMatchers(publicRoutes).permitAll()
		 .antMatchers(userRoutes).hasRole("USER")//.access("hasRole('USER')")
		 .antMatchers(adminRoutes).hasRole("ADMIN") //.access("hasRole('ADMIN')")
		 .anyRequest()
		 .authenticated()
		 .and()
		 .csrf()
		 .disable()
		 .formLogin().loginPage("/login").permitAll()
//		 .failureForwardUrl("/login?error")
//		 .successHandler(authsucc)
		 .successForwardUrl("/")
		 .failureHandler(authenticationFailureHandler)
		 .defaultSuccessUrl("/")
		 .usernameParameter("username")
		 .passwordParameter("password")
		 .and().logout()
		 .logoutUrl("/logout")
		 .invalidateHttpSession(true)
		 .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
		 .logoutSuccessUrl("/login?logout").permitAll().and().exceptionHandling()
		 .accessDeniedPage("/error-404")
		 .and()
		 .exceptionHandling().authenticationEntryPoint(restAuthenticationEntryPoint)
		 .and()
		 .sessionManagement()//.invalidSessionUrl("/loginFailed")
		 .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
		 .maximumSessions(1)
		 .expiredUrl("/login?expired");

//		http  
//			.authorizeRequests()
//			.antMatchers(publicRoutes).permitAll()
//			.antMatchers(adminRoutes).hasAnyRole("USER").anyRequest().authenticated()
//			.and()
//			.formLogin().loginPage("/login").defaultSuccessUrl("/homepage", true).failureUrl("/login?error").permitAll()
//			.and()
//			.logout().logoutUrl("/logout").logoutSuccessUrl("/login").permitAll();


//		http.authorizeRequests().antMatchers(publicRoutes).permitAll()
//        .anyRequest().authenticated()
//        .and()
//        .formLogin().loginPage("/login").permitAll().successForwardUrl("/homepage").permitAll().failureForwardUrl("/login?error").permitAll()
//        .and()
//        .logout().permitAll();

	}
 
	@Override
	public void configure(WebSecurity web) {
		web.ignoring().antMatchers("/resources/**", "/static/**", "/css/**", "/js/**", "/images/**");
	}
	
}

