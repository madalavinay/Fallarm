package com.fallarm.database;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.fallarm.util.EmailService;
import com.fallarm.util.HibernateUtil;

public class PersonManager {

	public String[] listMonitors() {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			Query q = session.createQuery(
					"select pid from Person_information where nurse_id is null or nurse_id='' order by pid");
			List l = q.list();
			t.commit();
			HibernateUtil.closeSession();
			if (l.size() <= 0) {
				return new String[] {};
			}
			String monitors[] = new String[l.size()];

			for (int i = 0; i < l.size(); i++) {
				monitors[i] = (String) l.get(i);
			}

			return monitors;
		} catch (Exception e) {
			HibernateUtil.closeSession();
			return new String[] {};
		}
	}

	public String[] listUsersByMonitor(String userId) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			Query q = session.createQuery("select pid from Person_information where pid='" + userId + "' or nurse_id='"
					+ userId + "' order by pid");
			List l = q.list();
			t.commit();
			HibernateUtil.closeSession();
			if (l.size() <= 0) {
				return new String[] {};
			}
			String monitors[] = new String[l.size()];

			for (int i = 0; i < l.size(); i++) {
				monitors[i] = (String) l.get(i);
			}

			return monitors;
		} catch (Exception e) {
			e.printStackTrace();
			return new String[] {};
		}
	}

	public void insertPersonDetails(Person_information p, String operation) {
		Session session = HibernateUtil.currentSession();
		Transaction t = session.beginTransaction();
		if (operation != null && operation.equals("save")) {
			session.save(p);
			t.commit();

			EmailService s = new EmailService();
			s.sendEmail(p);
		}
		if (operation != null && operation.equals("update")) {
			session.saveOrUpdate(p);
			t.commit();
		}

		HibernateUtil.closeSession();
	}

	public Person_information findPerson(String userId, String pwd) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			Query q = session.createQuery("from Person_information where pid='" + userId + "' and pwd='" + pwd + "'");
			List<Person_information> l = q.list();
			t.commit();
			HibernateUtil.closeSession();
			if (l.size() <= 0) {
				return null;
			}
			Person_information p = l.get(0);
			return p;
		} catch (Exception e) {
			HibernateUtil.closeSession();
			return null;
		}
	}

	public Person_information listPersonDetailsById(String userId) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			Query q = session.createQuery("from Person_information where pid='" + userId + "'");
			List<Person_information> l = q.list();
			t.commit();
			HibernateUtil.closeSession();
			if (l.size() <= 0) {
				return null;
			}
			Person_information p = l.get(0);
			return p;
		} catch (Exception e) {
			HibernateUtil.closeSession();
			return null;
		}
	}

	public boolean changePassword(String userId, String oldPwd, String newPwd) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			Query q = session
					.createQuery("from Person_information where pid='" + userId + "' and pwd='" + oldPwd + "'");
			List<Person_information> l = q.list();
			Person_information p = l.get(0);
			p.setPwd(newPwd);
			session.save(p);

			t.commit();
			HibernateUtil.closeSession();
			return true;
		} catch (Exception e) {
			HibernateUtil.closeSession();
			return false;
		}
	}

	public Person_information[] listPersonDetails(String user, int offset, int limit) {
		Session session = HibernateUtil.currentSession();
		Transaction t = session.beginTransaction();

		Query q1 = session.createQuery(
				"from Person_information where pid='" + user + "' or nurse_id='" + user + "' order by pid");
		q1.setFirstResult(offset);
		q1.setMaxResults(limit);
		List<Person_information> l = q1.list();
		Person_information p[] = new Person_information[l.size()];
		int i = 0;
		for (Iterator iterator = l.iterator(); iterator.hasNext();) {
			Person_information person = (Person_information) iterator.next();
			p[i] = person;
			i++;
		}

		t.commit();
		HibernateUtil.closeSession();

		return p;
	}

	public long countPersons(String userId) {
		Session session = HibernateUtil.currentSession();

		Transaction t = session.beginTransaction();
		Query q = session.createQuery(
				"select count(*) from Person_information where pid='" + userId + "' or nurse_id='" + userId + "'");
		Long count = (Long) q.uniqueResult();

		t.commit();
		HibernateUtil.closeSession();

		return count;
	}

	public void deletePerson(String id) {
		Session session = HibernateUtil.currentSession();

		Transaction t = session.beginTransaction();
		Query q = session.createQuery("delete from Person_information where pid='" + id + "'");
		q.executeUpdate();

		t.commit();
		HibernateUtil.closeSession();

	}

	public Person_information listPersonDetailsByDeviceId(String deviceid) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			Query q = session.createQuery("from Person_information where deviceid='" + deviceid + "'");
			List<Person_information> l = q.list();
			t.commit();
			HibernateUtil.closeSession();
			if (l.size() <= 0) {
				return null;
			}
			Person_information p = l.get(0);
			return p;
		} catch (Exception e) {
			HibernateUtil.closeSession();
			return null;
		}
	}
}