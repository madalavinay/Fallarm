package com.fallarm.util;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

    public static final ThreadLocal<Session> MAP = new ThreadLocal<Session>();

    private static final SessionFactory SESSION_FACTORY;

    private HibernateUtil() { }

    static {
        try {
            SESSION_FACTORY = new Configuration().configure().buildSessionFactory();
        } catch (HibernateException ex) {
            throw new RuntimeException("Exception building SessionFactory: " + ex.getMessage(), ex);
        }
    }

    public static Session currentSession() throws HibernateException {
        Session s = (Session)MAP.get();
        if (s == null) {
            s = SESSION_FACTORY.openSession();
            MAP.set(s);
        }
        return s;
    }

    public static void closeSession() throws HibernateException {
        Session s = (Session)MAP.get();
        MAP.set(null);
        if (s != null) {
            s.close();
        }
    }
}