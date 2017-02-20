#ifndef WIMU3DVIEWER_H
#define WIMU3DVIEWER_H

// Just in case: http://openglsamples.sourceforge.net/files/glut_obj.cpp


#include <QOpenGLWidget>
#include <QVector>
#include <QVector3D>

#include <QWheelEvent>
#include <QQuaternion>

class WIMU3DViewer : public QOpenGLWidget
{
public:
    WIMU3DViewer(QWidget *parent = Q_NULLPTR, Qt::WindowFlags f = Qt::WindowFlags());

    bool loadFromOBJFile(QString filename);
    void setRotation(QQuaternion rotation);

protected:
    void 	initializeGL();
    void 	paintGL();
    void 	resizeGL(int w, int h);

private:
    void wheelEvent(QWheelEvent *event);

    /*QVector<QVector3D>    m_vertexes;
    QVector<QVector3D>    m_facets;
    QVector<QVector3D>    m_normalVectors;
    QVector<QVector3D>    m_normals;*/
    QVector<QVector3D>    m_triangles;
    QVector<QVector3D>    m_triangleNormals;

    QString               m_modelName;

    QQuaternion           m_rotation;


};


#endif // WIMU3DVIEWER_H
