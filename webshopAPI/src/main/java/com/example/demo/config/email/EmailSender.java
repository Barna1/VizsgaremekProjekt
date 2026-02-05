package com.example.demo.config.email;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring6.SpringTemplateEngine;

import java.util.Map;

@Component
@RequiredArgsConstructor
public class EmailSender {
    private final JavaMailSender mailSender;
    private final SpringTemplateEngine thymeleafTemplateEngine;

    @Value("${spring.mail.username}")
    private String fromEmail;

    public void sendVCodeForPasswordReset(String toEmail, String vCode){

    }
    public void sendEmailAboutCancelledOrder(String toEmail) {

    }
    public void sendEmailAboutRegistration(String toEmail) {

    }
    public void sendEmailAboutOrder(String toEmail) {

    }
    public void sendEmailAboutOrderWithVCode(String toEmail, String vCode) {

    }
    private String getHtmlBody(String nameOfHtml, Map<String, Object> templateModel) {
        Context thymeleafContext = new Context();
        thymeleafContext.setVariables(templateModel);
        String htmlBody = thymeleafTemplateEngine.process(nameOfHtml, thymeleafContext);
        return htmlBody;
    }
}
